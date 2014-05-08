# Ruby 2.0+ has built in keyword arguments support
# On the backend, it is handled using a hash

def search(field, genre: nil, duration: 120)
  # Ruby automatically unpacks the keywords into local variables
  p [field, genre, duration]
end

search(:title) # => [:title, nil, 120]
search(:title, duration: 432) # => [:title, nil, 432]
search(:title, duration: 432, genre: "jazz")# => [:title, "jazz", 432]

# Ruby complains if you pass in an invalid option

# search(:title, harglebloogle: 432) # => ArgumentError

# you can collect these 'extra' hash arguments as a hash parameter
# by prefixing one element of your argument list with a **double splat

def search(field, genre: nil, duration: 120, **rest)
  p [field, genre, duration, rest]
end

search(:title, duration: 432, stars: 3, genre: "jazz", tempo: "slow")

# the above looks cleaner, but is really nothing more than a hash

options = { duration: 432, stars: 3, genre: "jazz", tempo: "slow" }
search(:title, options)
