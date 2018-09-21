require 'spec_helper'

RSpec.describe ServiceDowntimeSimulator::Modes do
  let(:valid_mode) { :hard_down }
  let(:invalid_mode) { :the_undertaker }

  describe '.for' do
    subject { described_class.for(mode) }

    context 'with a valid mode' do
      let(:mode) { valid_mode }

      it 'returns the class associated with that mode' do
        expect(subject).to be(ServiceDowntimeSimulator::Modes::HardDown)
      end
    end

    context 'with an invalid mode' do
      let(:mode) { invalid_mode }

      it 'raises an exception' do
        expect { subject }.to raise_error(ServiceDowntimeSimulator::Modes::NotFound)
      end
    end
  end

  describe '.exists?' do
    subject { described_class.exists?(mode) }

    context 'with an existing mode' do
      let(:mode) { valid_mode }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'with an non-existent mode' do
      let(:mode) { invalid_mode }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end
