module ServiceDowntimeSimulator
  class Middleware
    def initialize(app, config)
      @app = app
      @config = ServiceDowntimeSimulator::Config.for(config)
    end

    def call(env)
      return app.call(env) unless config.activated?

      config.mode_klass.new(app).call(env)
    end

    private

    attr_reader :app, :config
  end
end
