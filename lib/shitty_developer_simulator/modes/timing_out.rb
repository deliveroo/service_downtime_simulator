module ShittyDeveloperSimulator
  module Modes
    class TimingOut
      def call(*)
        sleep(15)
        super
      end

      private

      def status
        503
      end
    end
  end
end
