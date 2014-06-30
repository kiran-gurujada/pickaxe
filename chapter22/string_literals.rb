# A general delimited syntax is used to specify literal strings,
# regexes, shell commands etc
#
# This syntax starts with a percent character and is followed by a single
# character that identifies the literal's type.
#
# The delimeter can be any non-alphanumeric or non-multibyte character
# (Just use {} unless you need to nest multiple delimited objects)
#

s = "string"

p %q{single quoted string}
p %Q{double quoted #{s}}
p %{another double quoted #{s}}
p %w{ an array of strings }
p %i{ an array of symbols }
p %r{reg(ex|ular expression)}
p %s{a_symbol}
p %x{echo 'a shell command'}

p %q{delimited strings
may
continue
over
several lines. Line endings
and spaces
are including in the string.}

# Capitalized versions perform interpolation - e.g. %Q, %W, %I

