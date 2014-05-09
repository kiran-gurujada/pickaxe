# in Ruby, almost everything that can return a value, does
# e.g.  if  and  case  statements

song_type = if song.mp3_type == MP3::Jazz
              if song.written < Date.new(1935, 1, 1)
                Song::TradJazz
              else
                Song::Jazz
              end
            else
              Song::Other
            end

# and...

rating = case votes_cast
         when 0...10 then Rating::SkipThisOne
         when 10...50 then Rating::CouldDoBetter
         else Rating::Rave
         end

