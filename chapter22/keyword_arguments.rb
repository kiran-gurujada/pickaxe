# Ruby 2.0 methods may declare keyword arguments

def header(name, level: 1, upper: false)
  name = name.upcase if upper
  "<h#{level}>#{name}</h#{level}>"
end

header("Introduction") # => "<h1>Introduction</h1>"
header("Getting started", level: 2) # => "<h2>Getting started</h2>"
header("Conclusion", upper: true) # => "<h1>CONCLUSION</h1>"


# If you call a method that has keyword arguments and do not provide
# the corresponding values in the call's parameter list, defaults are
# used.
#
# If you pass keyword parameters that are not defined as arguments, an
# error will be raised unless you also define a double splat **arg.
#
# The double splat **arg will mop up the uncollected keyword parameters
# passed to the method.

def header(name, level: 1, upper: false, **attrs)
  name = name.upcase if upper
  attr_string = attrs.map {|k, v| %{#{k}="#{v}"} }.join(' ')
  "<h#{level} #{attr_string}>#{name}</h#{level}>"
end

header("TOC", class: "nav", level: 2, id: 123) # => <h2 class="nav" id="123">TOC</h2>
