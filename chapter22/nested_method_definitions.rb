def toggle
  def toggle
    "subsequent times!"
  end
  "first time"
end

p toggle # => "first time"
p toggle # => "subsequent times!"
p toggle # => "subsequent times!"
