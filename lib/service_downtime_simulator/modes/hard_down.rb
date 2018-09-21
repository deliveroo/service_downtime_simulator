module ServiceDowntimeSimulator
  module Modes
    class HardDown < Base
      private

      def status
        500
      end
    end
  end
end
