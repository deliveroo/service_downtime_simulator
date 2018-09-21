module ShittyDeveloperSimulator
  module Modes
    class IntermittentlyDown
      def call(env)
        unless knackered?
          return app.call(env)
        end

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
