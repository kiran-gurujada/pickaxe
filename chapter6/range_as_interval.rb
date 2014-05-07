# Ranges can also be used as an interval test -
# seeing whether some value falls within the interval represented by the range
# we do this using === the case equality operator (AKA 'can contain' operator)

(1..10) === 5 # => true
(1..10) === 15 # => false
(1..10) === 3.14159 # => true
('a'..'j') === 'c' # => true
('a'..'j') === 'z' # => false

# this is most often used in case statements

puts "Enter age of car in years..."
car_age = gets.to_f # let's assume it's 9.5

case car_age
when 0...1
  puts "Mmmm... new car smell"
when 1...3
  puts "Nice and new"
when 3...10
  puts "Reliable but slightly dinged"
when 10...30
  puts "Clunker"
else
  puts "Vintage gem"
end
