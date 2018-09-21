require 'spec_helper'

RSpec.describe ServiceDowntimeSimulator::Config do
  let(:enabled) { true }
  let(:mode) { nil }
  let(:logger) { double(error: nil) }
  let(:params) do
    {
      enabled: enabled,
      mode: mode,
      logger: logger
    }
  end

  subject { described_class.new(params) }

  describe '.for' do
    subject { described_class.for(params) }

    context 'when supplied a config instance' do
      let(:params) { described_class.new({}) }

      it 'returns said config instance' do
        expect(subject).to eq(params)
      end
    end

    context 'when supplied a hash' do
      it 'returns a new config instance' do
        expect(subject).to be_an_instance_of(described_class)
      end
    end

    context 'with anything else' do
      let(:params) { 'john torode' }

      it 'raises an exception' do
        expect { subject }.to raise_error(ServiceDowntimeSimulator::Config::WonkyInputError)
      end
    end
  end

  describe '#initialize' do
    context 'with a hash' do
      it 'returns an instance' do
        expect(subject).to be_an_instance_of(ServiceDowntimeSimulator::Config)
      end
    end

    context 'with anything else' do
      let(:params) { 'gregg wallace' }

      it 'raises an exception' do
        expect { subject }.to raise_error(ServiceDowntimeSimulator::Config::WonkyInputError)
      end
    end
  end

  context 'with a falsey `enabled` option' do
    let(:enabled) { false }

    describe '#enabled' do
      it 'returns false' do
        expect(subject.enabled).to eq(false)
      end
    end

    describe '#activated?' do
      it 'returns false' do
        expect(subject.activated?).to eq(false)
      end
    end
  end

  context 'with a truthy `enabled` option' do
    let(:enabled) { true }

    describe '#enabled' do
      it 'returns true' do
        expect(subject.enabled).to eq(true)
      end
    end

    context 'with a valid mode' do
      let(:mode) { :hard_down }

      describe '#activated?' do
        it 'returns true' do
          expect(subject.activated?).to eq(true)
        end
      end

      describe '#mode' do
        it 'returns the supplied mode' do
          expect(subject.mode).to eq(mode)
        end
      end

      describe '#mode_klass' do
        it 'returns the relevant mode implementation class' do
          expect(subject.mode_klass).to eq(ServiceDowntimeSimulator::Modes::HardDown)
        end
      end
    end

    shared_examples_for 'an invalid mode' do
      describe '#activated?' do
        it 'returns false' do
          expect(subject.activated?).to eq(false)
        end
      end

      describe '#mode' do
        it 'returns nil' do
          expect(subject.mode).to eq(nil)
        end

        it 'logs an error' do
          expect(logger).to receive(:error)
          subject.mode
        end
      end
    end

    context 'with a nil mode' do
      let(:mode) { nil }

      it_behaves_like 'an invalid mode'
    end

    context 'with an empty string mode' do
      let(:mode) { '' }

      it_behaves_like 'an invalid mode'
    end

    context 'with a non-existent mode' do
      let(:mode) { :john_cena }

      it_behaves_like 'an invalid mode'
    end
  end
end
