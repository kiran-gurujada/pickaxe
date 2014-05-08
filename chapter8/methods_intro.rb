def my_new_method(arg1, arg2, arg3)
  # code goes here
end

def my_other_new_method
  # no arguments
end

# default arguments can be supplied
def cool_dude(arg1="Miles", arg2="Coltrane", arg3="Roach")
  "#{arg1}, #{arg2}, #{arg3}"
end

# arguments can reference previous arguments
def surround(word, pad_width=word.length/2)
  "[" * pad_width + word + "]" * pad_width
end

# variable length argument lists are supplied using the *splat

def varargs(arg1, *rest)
  "arg1=#{arg1}. rest=#{rest.inspect}"
end

puts varargs("one") # => arg1=one. rest=[]
puts varargs("one", "two") # => arg1=one. rest=["two"]
puts varargs "one", "two", "three" # => arg1=one. rest=["two", "three"]

# a splat is sometimes used to specify arguments not used by the method,
# but perhaps used by the corresponding method in a superclass
class Parent < Object; end

class Child < Parent
  def do_something(*not_used)
    # our processing
    super # invoking super with no arguments is a special case - pass parameters given to original method
  end
end

# in this case you can leave off the name of the parameter and just
# write an asterisk. arguments are passed to super as before
class Child < Parent
  def do_something(*)
    # our_processing
    super
  end
end

# splats can be placed anywhere in the method's parameter list
def split_apart(first, *splat, last)
  puts "First: #{first.inspect}, splat: #{splat.inspect}, " +
    "last: #{last.inspect}"
end

split_apart(1, 2) # => First: 1, splat: [], last: 2
split_apart(1, 2, 3) # => First: 1, splat: [2], last: 3
split_apart(1, 2, 3, 4) # => First: 1, splat: [2, 3], last: 4
