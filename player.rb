class Player

  attr_reader :name, :symbol

  def initialize(name, symbol, board)

    @name = name
    @symbol = symbol
    @board = board

  end

  def play_move

    while true
      puts "\n#{@name}, it's your turn. Choose a column from 1 to 7.\n"
      attempted_move = gets.chomp
      if @board.move_valid?(attempted_move) == false
        puts "Invalid move, #{@name}"
      else
        break
      end
    end

    @board.play_move(attempted_move, @symbol) 

  end

end
