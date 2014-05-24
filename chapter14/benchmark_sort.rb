require 'benchmark'

puts "Generating random number array, please wait..."

array = (1..1_000_000).map { rand }

Benchmark.bmbm do |x|
  x.report("sort! (sort in place)") { array.dup.sort! }
  x.report("sort (sort into duplicated array)") { array.dup.sort }
end
