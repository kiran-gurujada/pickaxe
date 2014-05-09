# indexing with []square brackets is also implemented as a method call
# so when you write this:

# some_obj[1, 2, 3]

# you're actually doing this:

# some_obj.[](1, 2, 3)

# you can even define your own, like this:

class SomeClass
  def[](*params)
    #. . .
  end

  def[]=(*params)
    value = params.pop
    puts "Indexed with #{params.join(', ')}"
    puts "value = #{value.inspect}"
  end
end

s = SomeClass.new
s[1] = 2 # equivalent to s.[]=(1, 2)
s['cat', 'dog'] = 'enemies'
