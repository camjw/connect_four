class Board

  attr_accessor :board_state, :played_moves

  def initialize

    @board_state = [
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "[", "-", "-", "-", "-", "-", "-", "-", "]",
     "-", 1, 2, 3, 4, 5, 6, 7, "-"
     ]

    @played_moves = { "1" => [], "2" => [], "3" => [],
       "4" => [], "5" => [], "6" => [], "7" => [] }

  end

  def render

    @board_state.each_with_index { | tile, index |
      if index % 9 == 0 && index != 0
        puts ""
        print tile
      else
        print tile
      end
    }
  end

  def play_move(column, symbol)

    if @played_moves[column].length < 7
      @played_moves[column] << symbol
      @board_state[9 * (6 - @played_moves[column].length) + column.to_i] = symbol
      return true
    else
      puts "Invalid move"
      return false
    end

  end

  def game_won?(symbol)

    four_in_a_row = symbol * 4

    #first we check the columns, then the rows, then the diagonals

    @played_moves.keys.each { |i|
      col = @played_moves[i.to_s]
      if col[3] == symbol && col.join("").include?(four_in_a_row)
        return true
      end
    }

    6.times { |i|
    midpoint = 4 + (9 * i)
    if @board_state[midpoint] != "-" &&
      @board_state[midpoint - 3..midpoint + 3].join("").include?(four_in_a_row)
        return true
    end
    }

    #diagonal checking goes here
    4.times { |i|
      3.times { |j|
        start_index = i + (9 * j) + 1
        diag = @board_state[start_index] + @board_state[start_index + 10] +
          @board_state[start_index + 20] + @board_state[start_index + 30]
        if diag == four_in_a_row
          return true
        end
      }
    }

    4.times { |i|
      3.times { |j|
        start_index = i + (9 * j) + 7
        diag = @board_state[start_index] + @board_state[start_index + 8] +
          @board_state[start_index + 16] + @board_state[start_index + 24]
        if diag == four_in_a_row
          return true
        end
      }
    }

    return false

  end

end

i = 0
game = Board.new
while i < 42
  game.render
  puts "which column?"
  instruction = gets.chomp
  if i % 2 == 0
    game.play_move(instruction, "R")
  else
    game.play_move(instruction, "B")
  end
  if game.game_won?("R")
    game.render
    puts "Red won the game!"
    break
  elsif game.game_won?("B")
    game.render
    puts "Blue won the game!"
    break
  end
  i += 1
end
