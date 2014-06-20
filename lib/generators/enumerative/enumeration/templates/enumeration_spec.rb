require 'spec_helper'
require 'enumerative/enumeration_sharedspec'

describe <%= enumeration_class %> do

  it_should_behave_like 'an Enumeration'

  def self.keys
    %w(
    <% keys_and_values.sort { |a,b| a.first <=> b.first }.each do |k,v| -%>
  <%= k %>
    <% end -%>
)
  end

  self.keys.each do |key|

    const = key.upcase

    it "should have #{const}" do
      described_class.const_get( const ).should be_valid
    end

  end

  it "should have the correct select-box values " do
    described_class.to_select.should == [
    <% keys_and_values.sort { |a,b| a.first <=> b.first }.each do |k,v| -%>
  ["<%= v -%>", "<%= k -%>"],
    <% end -%>
]
  end

end
