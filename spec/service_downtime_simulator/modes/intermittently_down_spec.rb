require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe ServiceDowntimeSimulator::Modes::IntermittentlyDown do
  before { allow(app).to receive(:call).and_return([200, {}, 'groovy']) }

  it_behaves_like 'a mode'
end
