module ShittyDeveloperSimulator
  module Modes
    NotFound = Class.new(StandardError)

    AVAILABLE = {
      hard_down:                ShittyDeveloperSimulator::Modes::HardDown,
      intermittently_down:      ShittyDeveloperSimulator::Modes::IntermittentlyDown,
      successful_but_gibberish: ShittyDeveloperSimulator::Modes::SuccessfulButGibberish,
      timing_out:               ShittyDeveloperSimulator::Modes::TimingOut
    }.freeze

    def self.for(id)
      raise NotFound unless exists?(id)

      AVAILABLE[key]
    end

    def self.exists?(id)
      AVAILABLE.key?(id)
    end
  end
end
