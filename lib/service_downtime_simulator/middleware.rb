module ServiceDowntimeSimulator
  class Middleware
    def initialize(app, config)
      @app = app
      @config = ServiceDowntimeSimulator::Config.for(config)
    end

    def call(env)
      return app.call(env) if bypass?(env)

      config.mode_klass.new(app).call(env)
    end

    private

    attr_reader :app, :config

    def bypass?(env)
      !config.activated? || config.path_excluded?(env['PATH_INFO'])
    end
  end
end
