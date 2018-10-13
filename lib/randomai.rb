class RandomAI

  attr_reader :name, :symbol

  def initialize(symbol, board)

    @name = 'Random ' + rand(100).to_s
    @symbol = symbol
    @board = board

  end

  def play_move

    while true
      attempted_move = (1 + rand(7)).to_s
      if @board.move_valid?(attempted_move)
        break
      end
    end

    @board.play_move(attempted_move, @symbol)
  end

end
