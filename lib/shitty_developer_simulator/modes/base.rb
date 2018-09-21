module ShittyDeveloperSimulator
  module Modes
    class Base
      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env

        [status, headers, body]
      end

      private

      def headers
        {
          'X-SDS-Mode' => identifier
        }
      end

      def body
        "Simulated Response (#{identifier})"
      end

      def status
        raise NotImplementedError
      end

      def identifier
        self.class.name
      end

      attr_reader :app, :env
    end
  end
end
