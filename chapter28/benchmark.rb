# Times code execution and tabulates results. The Benchmark module is easier
# to use if you include it in your top level environment.
#
# - Compares the costs of four kinds of method dispatch:

require 'benchmark'
include Benchmark

string = "Stormy Weather"
m = string.method(:length)
bm(6) do |x|
  x.report("direct") { 100_000.times { string.length } }
  x.report("call") { 100_000.times { m.call } }
  x.report("send") { 100_000.times { string.send(:length) } }
  x.report("eval") { 100_000.times { eval "string.length" } }
end

# - Which is better, reading all of a dictionary then splitting it, or
# splitting it line by line as it is read?
#
# Use bmbm to run a rehearsal before timing.

bmbm(6) do |x|
  x.report("all") do
    str = File.read("/usr/share/dict/words")
    words = str.scan(/[-\w']+/)
  end
  x.report("lines") do
    words = []
    File.foreach("/usr/share/dict/words") do |line|
      words << line.chomp
    end
  end
end
