# SDS

[![CircleCI](https://circleci.com/gh/deliveroo/service_downtime_simulator/tree/master.svg?style=svg&circle-token=d66bc2c0246da5cdf4eeaeb6c9f7b10bcd74bb7b)](https://circleci.com/gh/deliveroo/service_downtime_simulator/tree/master)

This is a piece of Rack middleware that simulates failures you would want to tolerate in upstream services.

## Installation

### Rails

Add the following in `application.rb`:

```ruby
config.middleware.use(
  ServiceDowntimeSimulator::Middleware,
  config # See below for info about how to configure this
)
```

### Other Rack-based applications

Instructions TBC.

## Configuration

The middleware takes a `config` argument in the form of a hash. Said hash should have the following shape:

```ruby
{
  enabled: Boolean,
  mode: Symbol,
  logger: Logger
}
```

Here's what you can supply for each of those options:

- `enabled` (Boolean)
  - `true` will enable simulation of failures (assuming you supply a valid `mode`, see below)
  - `false` will disable simulation and your application will function as normal
- `mode` (Symbol)
  - `:hard_down` will cause all requests to return a 500 error
  - `:intermittently_down` will cause 50% of requests to return a 500 error
  - `:successful_but_gibberish` will return a 200, but with a response body that is not machine readable
  - `:timing_out` will wait for 15 seconds on each request, and then return a 503
- `logger` (Logger)
  - If supplied, useful debug information will be sent here

In order for the middleware to kick in, `enabled` must be explicitly set to `true` and `mode` must be a valid option. Unless both are explicitly supplied, the underlying application will continue to function as normal.

### Examples

Here's a couple of example configurations:

#### Hard-coded Hard Down

This example will always return a 500 for all requests.

```ruby
config.middleware.use(
  ServiceDowntimeSimulator::Middleware,
  {
    enabled: true,
    mode: :hard_down,
    logger: Rails.logger
  }
)
```

#### Environment-variable Controlled Simulation

This is a more practical example, allowing failure simulation to happen based on environment variables. It requires an environment variable with a specific value to enable the failure simulation, and also requires a mode to be provided. If either are missing, the app continues as normal. You can also use this pattern for feature flagging. Probably.

```ruby
config.middleware.use(
  ServiceDowntimeSimulator::Middleware,
  {
    enabled: ENV['FAILURE_SIMULATION_ENABLED'] == 'I_UNDERSTAND_THE_CONSEQUENCES_OF_THIS',
    mode: ENV['FAILURE_SIMULATION_MODE'],
    logger: Rails.logger
  }
)
```
