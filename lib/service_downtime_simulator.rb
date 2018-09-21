module ServiceDowntimeSimulator
  VERSION = '0.1.0'.freeze
end

require_relative 'service_downtime_simulator/config'
require_relative 'service_downtime_simulator/middleware'
require_relative 'service_downtime_simulator/modes/base'
require_relative 'service_downtime_simulator/modes/hard_down'
require_relative 'service_downtime_simulator/modes/intermittently_down'
require_relative 'service_downtime_simulator/modes/successful_but_gibberish'
require_relative 'service_downtime_simulator/modes/timing_out'
require_relative 'service_downtime_simulator/modes'
