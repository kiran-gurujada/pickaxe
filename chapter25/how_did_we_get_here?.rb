# In Ruby we can find out 'how we got here' using the method +caller+ which
# returns an array of strings representing the current call stack.

def cat_a
  puts caller
end
def cat_b
  cat_a
end
def cat_c
  cat_b
end

cat_c

# Produces:
#
# how_did_we_get_here?.rb:8:in `cat_b'
# how_did_we_get_here?.rb:11:in `cat_c'
# how_did_we_get_here?.rb:14:in `<main>'

# You can also use __callee__ which returns the name of the current method.

def my_method
  p __callee__
end

my_method # => :my_method
