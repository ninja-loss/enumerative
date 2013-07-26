class <%= enumeration_class %>

  def self.valid_keys
    %w(
    <% keys_and_values.each do |k,v| -%>
  <%= k %>
    <% end -%>
)
  end

  include Enumerative::Enumeration

  <% keys_and_values.each do |k,v| -%>
# <%= k.upcase %>
  <% end -%>

end
