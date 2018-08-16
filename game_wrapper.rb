require_relative "board"
require_relative "player"

class Gameplay

  attr_accessor :player_1, :player_2, :game_board

  def initialize

    puts "Welcome to Connect Four!\n\n"
    introduction

  end

  def introduction

    puts "Would you like to play a new two-player game? (Y/n)"

    instruction = gets.chomp.upcase
    if instruction == "N"
      puts "Goodbye!"
    elsif instruction == "Y"
      run_game
    else
      puts "Sorry, I didn't understand that."
      introduction
    end

  end

  def run_game

    puts "Player 1, what is your name?"
    name_1 = gets.chomp
    @player_1 = Player.new(name_1, "X")

    puts "Player 2, what is your name?"
    name_2 = gets.chomp
    @player_2 = Player.new(name_2, "\u2610")

    @game_board = Board.new

    current_player = @player_1
    attempted_move = ""


    while true
      @game_board.render
      while @game_board.move_valid?(attempted_move) == false
        puts "#{current_player.name}, it's your turn.\n"
        attempted_move = gets.chomp
        if @game_board.move_valid?(attempted_move) == false
          puts "Invalid move, #{current_player.name}"
        end
      end
      @game_board.play_move(attempted_move, current_player.symbol)
      attempted_move = ""
      if @game_board.game_won?(current_player.symbol)
        break
      end
      #the line below never triggers if the current player has won the game
      current_player = current_player == @player_1 ? @player_2 : @player_1
    end

    @game_board.render
    puts "The winner is #{current_player.name}!\n"

    introduction

  end


end

game = Gameplay.new
