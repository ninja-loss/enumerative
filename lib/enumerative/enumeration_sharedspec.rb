require 'spec_helper'

RSpec.shared_examples_for 'an Enumeration' do

  describe 'an instance' do

    let :instance do
      described_class.new 'foo'
    end

    let :immutable_error do
      RUBY_VERSION > "1.9.2" ?
        "can't modify frozen String" :
        "can't modify frozen string"
    end

    it 'should have the expected #key' do
      expect( instance.key ).to eq('foo')
    end

    it 'should have an immutable #key' do
      expect( instance ).not_to respond_to( :key= )

      expect {
        instance.key.gsub!( /./, 'x' )
      }.to raise_error( RuntimeError, immutable_error )
    end

    it 'should equal an equivalent instance' do
      expect( instance).to eq(described_class.new( 'foo' ))
    end

    it 'should have the expected string representation' do
      expect( instance.to_s ).to eq('foo')
    end

    describe 'that is valid' do

      subject { described_class.new described_class.valid_keys.first }

      it { should be_valid }

      it 'should have a #value' do
        expect( subject.value ).not_to be(nil)
      end

    end

    describe 'that is invalid' do

      subject { described_class.new "not a valid #{described_class.name} key" }

      it { should_not be_valid }

      it 'should not have a #value' do
        expect( subject.value ).to be(nil)
      end

    end

  end

end
