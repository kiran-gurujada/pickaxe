# use String methods to read in and clean up data from playlist file.
# Sample follows:
## /jazz/j00132.mp3  | 3:45 | Fats     Waller     | Ain't Misbehavin'
## /jazz/j00319.mp3  | 2:58 | Louis    Armstrong  | Wonderful World
## /bgrass/bg0732.mp3| 4:09 | Strength in Numbers | Texas Red
#
# We will need to:
#   1) break each line into fields
#   2) convert running times from mm:ss to seconds
#   3) remove extra spaces from artist names

Song = Struct.new(:title, :name, :length)

File.open('songdata') do |song_file|
  songs = []

  song_file.each do |line|
    file, length, name, title = line.chomp.split(/\s*\|\s*/)
    name.squeeze!(" ")
    mins, secs = length.scan(/\d+/)
    songs << Song.new(title, name, mins.to_i*60 + secs.to_i)
  end

  songs.each do |song|
    puts song
  end
end
