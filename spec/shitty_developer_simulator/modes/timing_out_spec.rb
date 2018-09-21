require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe ShittyDeveloperSimulator::Modes::TimingOut do
  before { allow(subject).to receive(:delay) }
  it_behaves_like 'a mode'
end
