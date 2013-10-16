require 'spec_helper'

shared_examples_for 'an Enumeration' do

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
      instance.key.should == 'foo'
    end

    it 'should have an immutable #key' do
      instance.should_not respond_to( :key= )

      expect {
        instance.key.gsub!( /./, 'x' )
      }.to raise_error( RuntimeError, immutable_error )
    end

    it 'should equal an equivalent instance' do
      instance.should == described_class.new( 'foo' )
    end

    it 'should have the expected string representation' do
      instance.to_s.should == 'foo'
    end

    describe 'that is valid' do

      subject { described_class.new described_class.valid_keys.first }

      it { should be_valid }

      it 'should have a #value' do
        subject.value.should_not == nil
      end

    end

    describe 'that is invalid' do

      subject { described_class.new "not a valid #{described_class.name} key" }

      it { should_not be_valid }

      it 'should not have a #value' do
        subject.value.should == nil
      end

    end

  end

end
