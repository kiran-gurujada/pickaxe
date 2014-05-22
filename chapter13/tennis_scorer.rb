class TennisScorer

  OPPOSITE_SIDE_OF_NET = { :server => :receiver, :receiver => :server }

  def initialize
    @score = { :server => 0, :receiver => 0 }
    @points = @score.dup
    @deuce = false
  end

  def score
    if @deuce
      'Deuce'
    else
      "#{@points[:server]}-#{@points[:receiver]}"
    end
  end

  def give_point_to(player)
    other = OPPOSITE_SIDE_OF_NET[player]
    fail "Unknown player #{player}" unless other
    @score[player] += 1

    @deuce = false
    @score.each_key do |player|
      if @score[player] <= 2
        @points[player] = @score[player] * 15
      elsif @score[player] == 3
        if @score[other] == 3
          @deuce = true
        else
          @points[player] = 40
        end
      elsif @score[player] == 4
        if @score[other] == 3
          @points[player] = 'A'
          @points[other] = 'server'
          break
        end
        @points[player] = 'W'
        @points[other] = 'L'
        break
      end
    end
  end
end
