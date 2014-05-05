require 'csv'
require_relative 'book_in_stock'

class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << BookInStock.new(row["ISBN"], row["Price"])
    end
  end

  # later we'll see how to use inject to sum a collection... apparently
  # actually I think I already know this, let's try a sample implementation...
  def total_value_in_stock
    sum = 0.0
    @books_in_stock.each {|book| sum += book.price}
    sum
    # sam's implementation using inject
    #@books_in_stock.inject(0) {|sum, book| sum += book.price}
  end
end
