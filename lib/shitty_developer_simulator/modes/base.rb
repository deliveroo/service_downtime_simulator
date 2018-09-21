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
          'X-SDS-Mode' => name
        }
      end

      def body
        "Simulated Response (#{name})"
      end

      def status
        raise NotImplementedError
      end

      attr_reader :app, :env
    end
  end
end
