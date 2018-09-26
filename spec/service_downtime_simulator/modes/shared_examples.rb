require 'spec_helper'

RSpec.shared_examples_for 'a mode' do
  let(:app) { double }
  subject { described_class.new(app) }

  describe '#call' do
    let(:env) { double }
    let(:response) { subject.call(env) }

    it 'returns an array with 3 elements' do
      aggregate_failures do
        expect(response).to be_an(Array)
        expect(response.length).to eq(3)
      end
    end

    describe 'first element (status code)' do
      let(:status_code) { response[0] }

      it 'is a valid numeric HTTP status code' do
        expect(status_code).to be_between(200, 599)
      end
    end

    describe 'second element (headers)' do
      let(:headers) { response[1] }

      it 'is a hash' do
        expect(headers).to be_a(Hash)
      end
    end

    describe 'third element (body)' do
      let(:body) { response[2] }

      it 'is an array' do
        expect(body).to be_a(Array)
      end

      it 'contains a string' do
        expect(body.first).to be_a(String)
      end
    end
  end
end
