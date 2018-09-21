require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe ServiceDowntimeSimulator::Modes::SuccessfulButGibberish do
  it_behaves_like 'a mode'
end
