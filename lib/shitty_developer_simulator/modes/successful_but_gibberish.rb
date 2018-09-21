class ShittyDeveloperSimulator::Modes::SuccessfulButGibberish < ShittyDeveloperSimulator::Modes::Base
  private

  def status
    200
  end

  def body
    cheeseboard.shuffle.join(' ')
  end

  def cheeseboard
    %w(stilton caerphilly cheddar gloucester wensleydale brie) * 10
  end
end
