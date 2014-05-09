# the defined? operator returns nil if it's argument is not defined,
# otherwise it returns a description of that argument

defined? 1 # => "expression"
defined? dummy # => nil
defined? printf # => "method"
defined? String # => "constant"
defined? $_ # => "global-variable"
defined? Math::PI # => "constant"
defined? a = 1 # => "assignment"
defined? 42.abs # => "method"
defined? nil # => "nil"
