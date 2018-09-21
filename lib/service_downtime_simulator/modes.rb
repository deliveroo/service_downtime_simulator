module ServiceDowntimeSimulator
  module Modes
    NotFound = Class.new(StandardError)

    AVAILABLE = {
      hard_down:                ServiceDowntimeSimulator::Modes::HardDown,
      intermittently_down:      ServiceDowntimeSimulator::Modes::IntermittentlyDown,
      successful_but_gibberish: ServiceDowntimeSimulator::Modes::SuccessfulButGibberish,
      timing_out:               ServiceDowntimeSimulator::Modes::TimingOut
    }.freeze

    def self.for(id)
      raise NotFound unless exists?(id)

      AVAILABLE[id]
    end

    def self.exists?(id)
      AVAILABLE.key?(id)
    end
  end
end
