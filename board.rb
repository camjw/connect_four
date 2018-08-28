class Board

  attr_accessor :board_state, :played_moves

  def initialize

    @board_state = [
     "|", "-", "-", "-", "-", "-", "-", "-", "|",
     "|", "-", "-", "-", "-", "-", "-", "-", "|",
     "|", "-", "-", "-", "-", "-", "-", "-", "|",
     "|", "-", "-", "-", "-", "-", "-", "-", "|",
     "|", "-", "-", "-", "-", "-", "-", "-", "|",
     "|", "-", "-", "-", "-", "-", "-", "-", "|"
     ]

    @board_labels = "-1234567-"

    @played_moves = { "1" => [], "2" => [], "3" => [],
       "4" => [], "5" => [], "6" => [], "7" => [] }

  end

  def render

    @board_state.each_with_index { | tile, index |
      if index % 9 == 0 && index != 0
        puts ""
      end
      print tile
    }

    print "\n" + @board_labels + "\n"

  end

  def move_valid?(column)

    return false unless (1..7).include?(column.to_i) &&
      @played_moves[column].length < 7

    return true

  end

  def play_move(column, symbol)

    @played_moves[column] << symbol
    @board_state[9 * (6 - @played_moves[column].length) + column.to_i] = symbol

  end

  def game_won?(symbol)

    four_in_a_row = symbol * 4

    # First we check the columns, then the rows, then the diagonals

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

    # Diagonal checking happens here

    diag_indices = [
      1, 2, 3, 4,
      10, 11, 12, 13,
      19, 20, 21, 22,
    ]

    diag_indices.each { | start_index |
      puts start_index
      puts @board_state
      down_diag = @board_state[start_index] + @board_state[start_index + 10] +
        @board_state[start_index + 20] + @board_state[start_index + 30]

      up_diag = @board_state[start_index + 3] + @board_state[start_index + 11] +
        @board_state[start_index + 19] + @board_state[start_index + 27]

      if up_diag == four_in_a_row || down_diag == four_in_a_row
        return true
      end

    }


    return false

  end

end
