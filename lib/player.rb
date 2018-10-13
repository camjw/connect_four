# frozen_string_literal: true

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol, board)
    @name = name
    @symbol = symbol
    @board = board
  end

  def play_move
    puts "\n#{@name}, it's your turn. Choose a column from 1 to 7.\n"
    attempted_move = $stdin.gets.chomp
    if @board.move_valid?(attempted_move) == false
      puts "Invalid move, #{@name}"
      play_move if ENV['TEST_ENV'] != 'test'
    else
      @board.play_move(attempted_move, @symbol)
    end
  end
end
