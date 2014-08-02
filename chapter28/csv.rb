# CSV library for Ruby
#
# - reads a file containing csv data and processes line by line

require 'csv'
CSV.foreach("support/csvfile") do |row|
  qty = row[0].to_i
  price = row[2].to_f
  printf "%20s: $%5.2f %s\n", row[1], qty*price, row[3] || " ---"
end

# - processes a CSV file that contains a header line. Automatically converts
# fields that look like numbers.

total_cost = 0
CSV.foreach("support/csvfile_hdr", headers: true, converters: :numeric) do |data|
  total_cost += data["Count"] * data["Price"]
end

puts "Total cost is #{total_cost}"
