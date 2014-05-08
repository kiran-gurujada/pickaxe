def mixed_case(name)
  name.downcase.gsub(/\b\w/) {|first| first.upcase }
end

p mixed_case("DAVE THOMAS") # => "Dave Thomas"
p mixed_case("dave thomas") # => "Dave Thomas"
p mixed_case("dAvE tHoMas") # => "Dave Thomas"

# can also be written as
def mixed_case(name)
  name.downcase.gsub(/\b\w/, &:upcase)
end
