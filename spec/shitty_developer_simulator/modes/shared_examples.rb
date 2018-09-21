require 'spec_helper'

RSpec.shared_examples_for 'a mode' do
  describe '#call' do
    it 'returns an array with 3 elements'

    describe 'first element (status code)' do
      it 'is a valid numeric HTTP status code'
    end

    describe 'second element (headers)' do
      it 'is a hash'
      it 'includes an X-SDS-Mode'
    end

    describe 'third element (body)' do
      it 'is a string'
    end
  end
end