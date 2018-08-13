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

    @played_moves = { 1 => [], 2 => [], 3 => [],
       4 => [], 5 => [], 6 => [], 7 => [] }

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
      @board_state[9 * (6 - @played_moves[column].length) + column] = symbol
      return true
    else
      puts "Invalid move"
      return false
    end

  end


end

game = Board.new
i = 0
while i < 10
  puts "which column?"
  column = gets.chomp
  game.play_move(column.to_i, "£")
  game.render
  i += 1
end
