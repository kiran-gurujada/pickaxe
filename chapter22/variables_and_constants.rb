# Ruby variables and constants hold references to objects.
#
# Variables themselves do not have an intrinsic type.
# Instead the type is defined solely by which messages the object
# referenced by the variable responds to.
#
# A Ruby constant is also a reference to an object. Constants are
# created when they are first assigned to (usually in a class or
# module definition).
#
# Ruby actually lets you alter the value of a constant (so it's not really
# a constant at all then is it?).

MY_CONST = 1
puts "First MY_CONST = #{MY_CONST}"

MY_CONST = 2  # generates a warning but still sets the const
puts "Then MY_CONST = #{MY_CONST}"

# Although constants should not be changed, you can alter the internal
# states of the objects they reference (freeze objects to prevent this).
#
# This is because assignment potentially can _alias_ objects (create two
# references to the same object).

MY_CONST2 = "Tim"
MY_CONST2[0] = "J"  # alter string referenced by const
puts MY_CONST2  # => "Jim"

## Scopes of constants and variables
#
# Constants defined within a class/module may be referenced 'as-is'
# anywhere within that scope.
#
# Outside their class/module, they must be referenced using the scope
# operator +::+, prefixed by an expression that returns the enclosing
# class/module.
#
# Constants defined outside any class or module (i.e. on main) may be
# accessed 'as-is' or by using the scope operator with an empty prefix
# (to make it explicit).
#
# Constants may NOT be defined in methods.
#
# Constants may be added to classes/modules from outside using the scope
# name and operator before the constant name.

OUTER_CONST = 99
class Const
  def get_const
    CONST
  end
  CONST = OUTER_CONST + 1
end
puts Const.new.get_const  # => 100
puts Const::CONST  # => 100
puts ::OUTER_CONST  # => 99
Const::NEW_CONST = 123

# Global variables are available throughout the program. Every reference to
# a particular global name always returns the same object.
# Referencing an uninitialized global variable returns nil.

# Class variables are available throughout a class or module body. Class
# variables must be initialized before use. A class variable is shared among
# all instances of a class and is available within the class itself.

class Song
  @@count = 0

  def initialize
    @@count += 1
  end

  def Song.get_count
    @@count
  end
end

# Class variables belong to the innermost enclosing class or module.
# Class variables used at the top level are defined in +Object+ and thus
# behave like global variables.
#
# Class variables are inherited by children but propagate upward if first
# defined in a child.
#
# ~ Ridiculously convoluted code example follows ~
#
# UPSHOT: DON'T use class variables, they are a nightmare.

# Instance variables are available within instance methods throughout a
# class body.
# Referencing an uninitialized instance variable returns nil.
# Each object has it's own unique set of instance variables.

# Local variables have statically defined scope but dynamically defined
# existence (WTF?).
#
# A local variable is created dynamically when it is first assigned a value
# during program execution.
# Howver, the scope of a local variable is statically determined to be the
# immediately enclosing block/method/class/module/top-level.
#
# Two local variables with the same name can exist if they are in different
# scopes.

# Method parameters are considered to be variables local to that method.

# Block parameters are assigned values when the block is invoked. If a local
# variable is first assigned in a block, it is local to that block.
#
# If a block uses a variable previously defined in the surrounding scope,
# the block will share that variable with the scope.
# TWO EXCEPTIONS:
# - Block parameters are always local to the block
# - Variables listed after a semicolon at the end of the block parameter list
# are always local to the block
#
# If a block parameter has the same name as a parameter in the surrounding
# scope, it will +shadow+ it.
#
# The block takes on the set of local variables in existence at the time of
# its creation. These form part of its binding.

# The bodies of while, until and for loops are part of the scope that
# surrounds them.

# Predefined variables
#
# Most of these have impenetrable names like $! and $@ (thanks, Perl).
# English versions are defined in the English library.
