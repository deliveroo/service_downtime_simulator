require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe ShittyDeveloperSimulator::Modes::IntermittentlyDown do
  it_behaves_like 'a mode'
end