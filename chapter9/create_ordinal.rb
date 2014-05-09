require 'chronic'

File.open("ordinal", "w") do |file|
  (1..10).each do |line_number|
    file << "#{line_number.humanize}\n"
  end
end
