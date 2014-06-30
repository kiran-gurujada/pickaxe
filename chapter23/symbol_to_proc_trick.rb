# Ruby implements +to_proc+ for symbols.
# So you can replace this:

names = %w{ ant bee cat }
result = names.map {|name| name.upcase}

# with this:

names = %w{ ant bee cat }
result = names.map(&:upcase)
