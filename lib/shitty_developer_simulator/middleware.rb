module ShittyDeveloperSimulator
  class Middleware
    def initialize(app, config)
      @app = app
      @config = ShittyDeveloperSimulator::Config.from(config)
    end

    def call(env)
      return app.call(env) unless config.activated?

      config.mode_klass.new(app).call(env)
    end

    private

    attr_reader :app, :config
  end
end
