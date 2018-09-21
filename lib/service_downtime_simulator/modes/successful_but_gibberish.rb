module ServiceDowntimeSimulator
  module Modes
    class SuccessfulButGibberish < Base
      private

      def status
        200
      end

      def body
        cheeseboard.shuffle.join(' ')
      end

      def cheeseboard
        %w[stilton caerphilly cheddar gloucester wensleydale brie] * 10
      end
    end
  end
end
