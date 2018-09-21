require 'spec_helper'

RSpec.describe ServiceDowntimeSimulator::Middleware do
  let(:app) { double }
  let(:config) { {} }
  let(:env) { double }

  subject { described_class.new(app, config) }

  describe '#initialize' do
    it 'returns an instance' do
      expect(subject).to be_an_instance_of(described_class)
    end
  end

  describe '#call' do
    before do
      allow(ServiceDowntimeSimulator::Config).to receive(:for).and_return(config)
    end

    context 'with an activated config' do
      let(:mode) { double(call: []) }
      let(:mode_klass) { double(new: mode) }
      let(:config) { double(activated?: true, mode_klass: mode_klass) }

      it 'runs a downtime simulation' do
        expect(config).to receive(:mode_klass)
        expect(mode_klass).to receive(:new)
        expect(mode).to receive(:call)

        subject.call(env)
      end
    end

    context 'with an non-activated config' do
      let(:config) { double(activated?: false) }

      it 'routes through to next middleware' do
        expect(app).to receive(:call)
        subject.call(env)
      end
    end
  end
end
