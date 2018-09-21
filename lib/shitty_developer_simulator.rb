module ShittyDeveloperSimulator
  VERSION = '0.1.0'.freeze
end

require_relative 'shitty_developer_simulator/config'
require_relative 'shitty_developer_simulator/middleware'
require_relative 'shitty_developer_simulator/modes/base'
require_relative 'shitty_developer_simulator/modes/hard_down'
require_relative 'shitty_developer_simulator/modes/intermittently_down'
require_relative 'shitty_developer_simulator/modes/successful_but_gibberish'
require_relative 'shitty_developer_simulator/modes/timing_out'
require_relative 'shitty_developer_simulator/modes'
