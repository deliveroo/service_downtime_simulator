require 'spec_helper'

RSpec.describe ServiceDowntimeSimulator::Middleware do
  let(:app) { double(mode_klass: double(new: double(call: 'hello!'))) }
  let(:enabled) { true }
  let(:excluded_paths) { [] }
  let(:config) do
    {
      enabled: enabled,
      mode: :hard_down,
      excluded_paths: excluded_paths
    }
  end

  subject(:middleware) { described_class.new(app, config) }

  describe '#call' do
    let(:path) { '/' }
    let(:env) { { 'PATH_INFO' => path } }

    subject { middleware.call(env) }

    context 'if not enabled' do
      let(:enabled) { false }

      it 'falls through' do
        expect(app).to receive(:call)
        subject
      end
    end

    context 'if for a path that is explicitly excluded' do
      let(:path) { '/excluded' }
      let(:excluded_paths) { ['/excluded'] }

      it 'falls through' do
        expect(app).to receive(:call)
        subject
      end
    end

    context 'otherwise' do
      let(:status) { subject[0] }
      let(:headers) { subject[1] }
      let(:body) { subject[2] }

      it 'has a 500 status code' do
        expect(status).to eq(500)
      end

      it 'has headers' do
        expect(headers).to include('X-SDS-Mode')
      end

      it 'has a body' do
        expect(body.first).to match(/^Simulated Response/)
      end
    end
  end
end
