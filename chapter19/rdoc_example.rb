# rdoc comments can be applied automatically:

# Calculate the minimal-cost path through the graph using Debrinski's algorithm,
# now with optimized inverse flux capacitor technology.
def calculate_path
  #...
end

# or you can use specific rdoc start/end blocks:

=begin rdoc
Calculate the minimal-cost path through the graph using Debrinski's algorithm,
now with optimized inverse flux capacitor technology.
=end
def calculate_path
  #...
end

# Code blocks are usually enclosed in + for monospace text, e.g.:
# cat:: Small domestic animal
# +cat+:: Command to copy stdin to stdout

# Headings are entered on lines starting with equals signs
# = Level one heading
# == Level two heading
# etc...

# For horizontal lines use three or more hyphens (like markdown)
# ----
# next section...

# if a method calls yield, parameters passed to yield are also displayed.
def fred
  # ...
  yield line, address
end

# you can suppress this using :yield: on the same line as the method definition
# other rdoc modifiers include :nodoc:, :doc:, :stopdoc: / :startdoc: among others.
