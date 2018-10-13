require_relative 'board'
require_relative 'player'
require_relative 'randomai'

class Gameplay

  attr_accessor :players, :game_board

  def initialize

    @players = { 1 => nil, 2 => nil }
    puts "Welcome to Connect Four!\n\n"
    introduction

  end

  def introduction

    # This chunk needs refactoring
    puts 'Would you like to play a new game? (Y/n)'

    instruction = gets.chomp.upcase
    if instruction == 'N'
      puts 'Goodbye!'
    elsif instruction == 'Y'
      run_game
    else
      puts 'Sorry, I didn't understand that.'
      introduction
    end

  end

  def get_'layers

    @game_board = Board.new

    @players.keys.each { | key |
      while true
        puts "Is Player #{key} human? (Y/n)"
        human = gets.chomp.upcase

        # The key - 1 bit is to make sure that we can index the players from 1,
        # even though arrays are indexed from 0

        if human == 'Y'
          puts "Player #{key}, what is your name?"
          name = gets.chomp
          @players[key] = Player.new(name, ['X', 'O'][key - 1], @game_board)
          break
        elsif human == 'N'
          @players[key] = RandomAI.new(['!', '?'][key - 1], @game_board)
          break
        else
          puts "Sorry, I didn't understand that."
        end
      end
    }

  end

  def run_game

    get_players

    current_player = @players[1]
    total_moves = 0

    while true
      @game_board.render
      current_player.play_move

      if @game_board.game_won?(current_player.symbol)
        break
      end

      total_moves += 1

      # The line below never triggers if the current player has won the game
      current_player = current_player == @players[1] ? @players[2] : @players[1]

      if total_moves == 42
        break
      end

    end

    @game_board.render
    if total_moves < 42
      puts "\nThe winner is #{current_player.name}!\n"
    else
      puts "\nThe game is a tie!\n"
    end

    introduction

  end


end

game = Gameplay.new
