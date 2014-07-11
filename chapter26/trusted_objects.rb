# Ruby 1.9 adds +trust+, a new dimension to the concept of safety.
#
# All objects are marked as being trusted or untrusted. Running code can
# also be considered trusted or not. Untrustworthiness is contagious, so
# an environment deemed untrusted will spawn untrusted objects. This can
# be used to create sandboxes.
#
# Objects created with $SAFE < 3 are trusted. However, objects created with
# $SAFE >= 3 will be marked untrusted. Untrusted code can only modify untrusted
# objects, so code at levels 3 and 4 will not be able to modify objects
# created at a lower safe level.

dog = "dog is trusted"
cat = lambda { $SAFE = 3; "cat is untrusted" }.call

puts "dog.untrusted? = #{dog.untrusted?}"
puts "cat.untrusted? = #{cat.untrusted?}"

# running at safe level 1, these operations will succeed
puts dog.upcase!
puts cat.upcase!

# running at safe level 4, we can modify the cat
lambda { $SAFE = 4; cat.downcase! }.call
puts "cat is now '#{cat}'"

# but we cannot modify dog
lambda { $SAFE = 4; dog.downcase! }.call
puts "so this point is never reached"

# You can set and unset the trusted status of an object using Object#untrust
# and Object#trust (not modifiable at $SAFE = 4).
