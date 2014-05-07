triangular_numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end

def infinite_select(enum, &block)
  Enumerator.new do |yielder|
    enum.each do |value|
      yielder.yield(value) if block.call(value)
    end
  end
end

p infinite_select(triangular_numbers) {|val| val % 10 == 0}.first(5)

# some lazy loading voodoo written by Dave Thomas
def Integer.all
  Enumerator.new do |yielder, n: 0|
    loop {yielder.yield(n += 1) }
  end.lazy
end

p Integer.all.select{|i| (i%3).zero?}.first(10)
