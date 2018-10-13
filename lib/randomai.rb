# frozen_string_literal: true

class RandomAI
  attr_reader :name, :symbol

  def initialize(symbol, board)
    @name = 'Random ' + rand(100).to_s
    @symbol = symbol
    @board = board
  end

  def play_move
    attempted_move = rand(1..7).to_s
    if @board.move_valid?(attempted_move) == false
      play_move if ENV['TEST_ENV'] != 'test'
    else
      @board.play_move(attempted_move, @symbol)
    end
  end
end
