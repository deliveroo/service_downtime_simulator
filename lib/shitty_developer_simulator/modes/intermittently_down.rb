module ShittyDeveloperSimulator
  module Modes
    class IntermittentlyDown
      def call(env)
        return app.call(env) unless knackered?

        super
      end

      private

      def status
        500
      end

      def knackered?
        [true, false].sample
      end
    end
  end
end
