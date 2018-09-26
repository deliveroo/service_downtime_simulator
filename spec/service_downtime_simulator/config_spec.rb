require 'spec_helper'

RSpec.describe ServiceDowntimeSimulator::Config do
  let(:enabled) { true }
  let(:mode) { :brie }
  let(:excluded_paths) { [] }
  let(:logger) { double(error: nil) }
  let(:params) do
    {
      enabled: enabled,
      mode: mode,
      logger: logger,
      excluded_paths: excluded_paths
    }
  end

  subject(:config) { described_class.new(params) }

  describe '.for' do
    subject { described_class.for(params) }

    context 'when supplied a config instance' do
      let(:params) { described_class.new({}) }

      it { is_expected.to eq(params) }
    end

    context 'when supplied a hash' do
      it { is_expected.to be_an_instance_of(described_class) }
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
      it { is_expected.to be_an_instance_of(ServiceDowntimeSimulator::Config) }
    end

    context 'with anything else' do
      let(:params) { 'gregg wallace' }

      it 'raises an exception' do
        expect { subject }.to raise_error(ServiceDowntimeSimulator::Config::WonkyInputError)
      end
    end
  end

  describe '#enabled' do
    subject { config.enabled }

    context 'when enabled' do
      let(:enabled) { true }

      it { is_expected.to eq(true) }
    end

    context 'when disabled' do
      let(:enabled) { false }

      it { is_expected.to eq(false) }
    end
  end

  describe '#activated?' do
    subject { config.activated? }

    context 'when enabled' do
      let(:enabled) { true }

      context 'with a valid mode' do
        let(:mode) { :hard_down }

        it { is_expected.to be(true) }
      end

      context 'with an invalid mode' do
        let(:mode) { :bender_bending_rodriguez }

        it { is_expected.to be(false) }
      end

      context 'without a mode' do
        it { is_expected.to be(false) }
      end
    end

    context 'when disabled' do
      let(:enabled) { false }

      it { is_expected.to be(false) }
    end
  end

  describe '#mode' do
    subject { config.mode }

    context 'with a valid mode' do
      before { allow(ServiceDowntimeSimulator::Modes).to receive(:exists?).and_return(true) }

      it { is_expected.to eq(mode) }
    end

    context 'with an invalid mode' do
      before { allow(ServiceDowntimeSimulator::Modes).to receive(:exists?).and_return(false) }

      it 'logs an error' do
        expect(logger).to receive(:error)
        subject
      end

      it { is_expected.to eq(nil) }
    end
  end

  describe '#mode_klass' do
    subject { config.mode_klass }

    context 'with a valid mode' do
      let(:mode) { :hard_down }

      it { is_expected.to eq(ServiceDowntimeSimulator::Modes::HardDown) }
    end

    context 'otherwise' do
      it 'blows up' do
        expect { subject }.to raise_error(ServiceDowntimeSimulator::Modes::NotFound)
      end
    end
  end

  describe '#excluded_paths' do
    subject { config.excluded_paths }

    context 'with an array of strings' do
      let(:excluded_paths) { %w[brie stilton] }

      it { is_expected.to eq(excluded_paths) }
    end

    context 'with an array of mixed types' do
      let(:excluded_paths) { ['bananas', 1337] }

      it 'logs an error' do
        expect(logger).to receive(:error)
        subject
      end

      it { is_expected.to eq([]) }
    end

    context 'with a non-array' do
      let(:excluded_paths) { 'tony hawk pro skater 2 is the best game ever made, change my mind' }

      it 'logs an error' do
        expect(logger).to receive(:error)
        subject
      end

      it { is_expected.to eq([]) }
    end

    context 'with nil' do
      let(:excluded_paths) { nil }

      it 'logs an error' do
        expect(logger).to receive(:error)
        subject
      end

      it { is_expected.to eq([]) }
    end
  end

  describe '#path_excluded?' do
    let(:excluded_paths) { ['/ham'] }

    subject { config.path_excluded?(path) }

    context 'with a valid path' do
      let(:path) { '/ham' }

      it { is_expected.to be(true) }
    end

    context 'with an invalid path' do
      let(:path) { '/cheese' }

      it { is_expected.to be(false) }
    end
  end
end
