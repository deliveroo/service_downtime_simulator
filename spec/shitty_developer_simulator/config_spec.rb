require 'spec_helper'

RSpec.describe ShittyDeveloperSimulator::Config do
  describe '.for' do
    subject { described_class.for(params) }

    context 'when supplied a config instance' do
      let(:params) { described_class.new({}) }

      it 'returns said config instance' do
        expect(subject).to eq(params)
      end
    end

    context 'when supplied a hash' do
      let(:params) { {} }

      it 'returns a new config instance' do
        expect(subject).to be_an_instance_of(described_class)
      end
    end

    context 'with anything else' do
      let(:params) { 'john torode' }

      it 'raises a WonkyInputError' do
        expect { subject }.to raise_error(ShittyDeveloperSimulator::Config::WonkyInputError)
      end
    end
  end

  describe '#initialize' do
    context 'with a hash' do
      it 'returns an instance'
    end

    context 'with anything else' do
      it 'raises'
    end
  end

  context 'with a falsey `enabled` option' do
    describe '#enabled' do
      it 'returns false'
    end

    describe '#activated?' do
      it 'returns false'
    end
  end

  context 'with a truthy `enabled` option' do
    describe '#enabled' do
      it 'returns true'
    end

    context 'with a valid mode' do
      describe '#activated?' do
        it 'returns true'
      end
    end

    context 'with a nil mode'

    context 'with an empty string mode'

    context 'with an invalid mode'
  end
end
