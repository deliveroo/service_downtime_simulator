module ShittyDeveloperSimulator
  module Modes
    class TimingOut < Base
      def call(*)
        delay(15)
        super
      end

      def delay(duration)
        sleep(duration)
      end

      private

      def status
        503
      end
    end
  end
end
