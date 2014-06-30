# The basic types in Ruby are numbers, strings, arrays, hashes, ranges,
# symbols and regexes.
#
# Integers and Floating Point numbers
#
# Integers are represented as Fixnum (fits within native machine word -1 bit)
# or Bignum (limited only by available memory). Ruby converts automatically
# between the two.
#
# Integers are written using an optional leading sign and an optional base
# indicator:
#
# 0d for decimal
# 0x for hex
# 0 or 0o for octal
# 0b for binary
#
# Underscores in digits are ignored.

p 123456
p 0d123456
p 123_456
p -543
p 0xaabb
p 0377
p 0o377
p -0b10_1010
# The following is a Bignum:
p 123_456_789_123_456_789_123
# The largest Fixnum is 2**(machine_bits - 2) - 1, because one bit is
# reserved to mark it as an integer rather than an object, and the other is
# to mark the sign. The final -1 is because computers start counting at 0,
# not at 1.
#
# Therefore, on a 64 bit system, the largest Fixnum in Ruby is
a = 2**62 - 1   # => 4611686018427387903
p a_b = a.to_s(base = 2)
puts "length: #{a_b.length}"


# A numeric literal with a decimal point and/or exponent is turned into
# a +Float+ object, corresponding to the native architecture's +double+
# data type.
#
# There must be at least one digit before the decimal point, and one digit
# between point and exponent.
#
# OK:
# 12.34
# -0.12
# 1234e-2
#
# Not OK:
#
# 1.e3
# .123
# 22.e4

p 12.34
p -0.1234e2
p 1234e-2

# Rational and complex numbers
# See classes Complex and Rational

# Strings
# Single quoted strings undergo minimal substitution
# Backslashes must be escaped, as well as literal single quotes
# Everything else is rendered as is.
# Examples:

puts 'hello'
puts 'a backslash \'\\\''
puts %q{simple string}
puts %q{nesting {really} works}
puts %q{escape a\} with backslash}
puts %q no_blanks_here ;

# Double quoted strings do substituions, e.g. #{inline ruby}, \n (newline)
# \b (backspace) \r (return) \nnn (octal character) \uXXX (litaral character codes) etc.

a = 123
puts "\123mile"
puts "Greek pi: \u03c0"
puts "Greek \u{70 69 3a 20 3c0}"
puts "Say \"Hello!\""
puts %Q{"I said 'nuts'", I said}
puts %Q{Try #{a + 1}, not #{a - 1}}
puts %<Try #{a + 1}, not #{a - 1}>
puts "Try #{a + 1}, not #{a - 1}"
puts %{ #{a = 1; b = 2; a + b} }

# You can also get the string corresponding to an ASCII character by using a ?

p ?a
p ?\n
p ?\C-a
p ?\M-a
p ?\M-\C-a
p ?\C-?

# Adjacent strings are concatenated.
# A string object is created every time a string literal is assigned or
# passed as a parameter

3.times do
  print 'hello'.object_id, " "
end


# Ranges
#
# expr..expr and expr...expr construct Range objects.
# The .. is inclusive, the ... exclusive (it's so fat it pushes the last number out)

# Arrays
# Constructed with comma-separated elements inside of square brackets.
# Trailing commas are ignored.

# arr = [ fred, 10, 3.14, "This is a string", barney("pebbles"), ]

# Construct arrays of strings using %w and %W

p %w{ fred wilma barney betty great\ gazoo }
p %w{ Hey!\tIt is now -#{Time.now}- }
p %W{ Hey! It", "is", "now", "-2013-05-27 12:31:31 -0500-"] }

# Hashes
# A Ruby hash is created by placing a list of key/value pairs between braces.
# Keys and values are separated by =>.

colors = { "red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f }

# if the keys are symbols, you can use the shortcut notation:

colors = {red: 0xf00, blue: 0x0f0, green: 0x00f}

# Keys and values in a particular hash may be of mixed types.
#
# Hash keys must respond to the message +hash+ by returning a hash code,
# and the hash code for a given key must not change.
# The keys in hashes must also be comparable using eql?
# If eql? returns true for two keys, then those keys are identical
# and must have the same hash code.
#
# If you keep an external reference to a hash key, then use that reference
# to alter the object (thus changing its hash code) the hash lookup may
# not work. You can force a reindex using +rehash+

arr = [1, 2, 3]
hash = { arr => 'value' }
p hash[arr]   # => "value"
arr[1] = 99
p hash    # => { [1, 99, 3] => "value" }
p hash[arr]   # => nil
hash.rehash
p hash[arr]   # => "value"

# Because strings are used frequently as hash keys, but string contents may
# be changed, Ruby treats string keys specially.
#
# If you use a +String+ object as a hash key, the hash will duplicate the string
# internally and use that copy as its key. The copy will be frozen. Any changes
# to the original string will not affect the hash.

a = "mystring"
myhash = { a => String }
p myhash[a]  # => String
a += '_modifed!'
myhash.rehash
p myhash[a]  # => nil
p myhash["mystring"]  # => String

# If you write your own classes and use instances of them as hash keys, you
# should make sure that either
# 1) the hashes of the key objects don't change
# or
# 2) you call Hash#rehash to reindex the hash if you do change it.

# Symbols
#
# A Ruby symbol is an identifier corresponding to a string of characters,
# usually a name. You can construct it by preceeding the name with a colon.
# The symbol for an abitrary string is constructed by preceeding the string
# literal with a colon - this can be used with double quoted strings to allow
# substitution when creating symbol names.

p :Object
p :my_variable
p :"Ruby rocks"
a = "cat"
p :'catsup'
p :"#{a}sup"
p :'#{a}sup'

# Only one symbol of a particular name can exist in Ruby.
# Other languages may call this _interning_ and label symbols _atoms_

# Regular Expressions
#
# Regex literals are objects of type +Regexp+. They can be created explicitly
# using Regexp.new or implicitly with the literal forms /pattern/ or
# %r{pattern}
#
# /pattern/
# /pattern/options
# %r{pattern}
# %r{pattern}options
# Regexp.new('pattern' <, options> )
#
# Options is one or more of:
# i (case insensitive)
# o (substitute once)
# m (matches newline)
# x (allow spaces and comments)
# n/e/s/u (text encoding)

# Names
#
# Ruby names are used to refer to constants, variables, methods, classes
# and modules.
#
# Certain names are reserved and should not be used for this purpose:
#
# __ENCODING__ , __FILE__ , __LINE__ , BEGIN , END , alias , and , begin , break , case , class , def , defined?  , do , else , elsif , end , ensure , false , for , if , in , module , next , nil , not , or , redo , rescue , retry , return , self , super , then , true , undef , unless , until , when , while , yield

# local variables: lower_case_letters
# instance variables: @start_with
# class variables: @double
# constant name: UppercaseFirstLetter
# global variables: $start_with
