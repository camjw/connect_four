# This class contains the board for Connect Four and checks when whether the
# game has been won and if moves are valid.
class Board

  attr_accessor :board_state, :played_moves

  def initialize
    @board_state = ['|', '-', '-', '-', '-', '-', '-', '-', '|'] * 6
    @board_labels = '-1234567-'

    @played_moves = { '1' => [], '2' => [], '3' => [],
                      '4' => [], '5' => [], '6' => [], '7' => [] }
  end

  def render
    @board_state.each_with_index do |tile, index|
      if (index % 9).zero? && index != 0
        puts ''
      end
      print tile
    end

    print "\n" + @board_labels + "\n"
  end

  def move_valid?(column)
    return false unless (1..7).cover?(column.to_i) &&
                        @played_moves[column].length < 7

    true
  end

  def play_move(column, symbol)
    @played_moves[column] << symbol
    @board_state[9 * (6 - @played_moves[column].length) + column.to_i] = symbol
  end

  def game_won?(symbol)
    horizontal_win?(symbol) || vertical_win?(symbol) || diagonal_win?(symbol)
  end

  def vertical_win?(symbol)
    @played_moves.keys.each do |index|
      col = @played_moves[index.to_s]
      return true if col[3] == symbol && col.join('').include?(symbol * 4)
    end

    false
  end

  def horizontal_win?(symbol)
    6.times do |index|
      midpoint = 4 + (9 * index)
      if @board_state[midpoint] != '-' &&
         @board_state[midpoint - 3..midpoint + 3].join('').include?(symbol * 4)
        return true
      end
    end

    false
  end

  def diagonal_win?(symbol)
    # Diagonal checking happens here

    diag_indices = [1, 2, 3, 4, 10, 11, 12, 13, 19, 20, 21, 22]

    diag_indices.each do |start_index|
      down_diag = @board_state[start_index] + @board_state[start_index + 10] +
                  @board_state[start_index + 20] +
                  @board_state[start_index + 30]

      up_diag = @board_state[start_index + 3] + @board_state[start_index + 11] +
                @board_state[start_index + 19] + @board_state[start_index + 27]

      return true if up_diag == symbol * 4 || down_diag == symbol * 4
    end

    false
  end
end
