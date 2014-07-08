# Ruby allows you to serialize objects via marshaling.
#
# You can use this facility to store them and rebuild them somewhere else
# if and when they are needed.
#
# Saving and object or some/all of its components is done via the method
# Marshal.dump. Typically you would dump an entire object tree starting
# with some given object. Later you can reconstitute the object using
# Marshal.load.
#
# e.g. in this example we save notes in a chord object:

Note = Struct.new(:value) do
  def to_s
    value.to_s
  end
end

class Chord
  def initialize(arr)
    @arr = arr
  end

  def play
    @arr.join('-')
  end
end

# Now we'll create a song and save using Marshal.dump.

c = Chord.new( [ Note.new("G"),
                 Note.new("Bb"),
                 Note.new("Db"),
                 Note.new("E") ] )

File.open("posterity", "w+") do |f|
  Marshal.dump(c, f)
end

# Finally, read it in and reload the objects from disk

chord = Marshal.load(File.open("posterity", "r"))
puts chord.play

# Cleanup
system("rm posterity")

# Not all objects can be dumped - bindings, instance of class IO and singleton
# objects cannot be saved outside a running Ruby environment.
#
# You can implement custom/partial serialization for these objects.
#
# Implement marshall_dump and marshal_load as instance methods on your class
# to get this behaviour.
#
# In this example, Special doesn't want to save one of it's internal attributes,
# @volatile:

class Special
  def initialize(valuable, volatile, precious)
    @valuable = valuable
    @volatile = volatile
    @precious = precious
  end

  def marshal_dump
    [ @valuable, @precious ]
  end

  def marshal_load(variables)
    @valuable = variables[0]
    @precious = variables[1]
    @volatile = "unknown"
  end

  def to_s
    "#@valuable #@volatile #@precious"
  end
end

obj = Special.new("Hello", "there", "World")
puts "Before: obj = #{obj}"
data = Marshal.dump(obj)

obj = Marshal.load(data)
puts "After: obj = #{obj}"

# By default marshaled objects are stored in a binary format. This is fast
# but may become incompatible if the interpreter changes.
#
# We can also marshal objects to YAML:

require 'yaml'

class Special
  def initialize(valuable, volatile, precious)
    @valuable = valuable
    @volatile = volatile
    @precious = precious
  end

  def to_yaml_properties
    %w{ @precious @valuable }
  end

  def to_s
    "#@valuable #@volatile #@precious"
  end
end

puts
puts "And now with YAML..."

obj = Special.new("Hello", "there", "World")
puts "Before: obj = #{obj}"
data = YAML.dump(obj)

obj = YAML.load(data)
puts "After: obj = #{obj}"
