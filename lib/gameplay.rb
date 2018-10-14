# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'randomai'

class Gameplay
  attr_accessor :players, :game_board, :testing

  def initialize(board: Board, player: Player, randomai: RandomAI, testing: false)
    @testing = testing
    @board = board
    @player = player
    @randomai = randomai
    @players = { 1 => nil, 2 => nil }
  end

  def start
    puts "Welcome to Connect Four!\n\n"
    introduction unless testing
  end

  def introduction
    # This chunk needs refactoring
    puts 'Would you like to play a new game? (Y/n)'

    instruction = $stdin.gets.chomp.upcase
    if instruction == 'N'
      puts 'Goodbye!'
    elsif instruction == 'Y'
      run_game
    else
      puts "Sorry, I didn't understand that."
      introduction unless testing
    end
  end

  def get_players
    @players.keys.each do |key|
      loop do
        puts "Is Player #{key} human? (Y/n)"
        human = $stdin.gets.chomp.upcase

        # The key - 1 bit is to make sure that we can index the players from 1,
        # even though arrays are indexed from 0

        if human == 'Y'
          puts "Player #{key}, what is your name?"
          name = $stdin.gets.chomp
          @players[key] = @player.new(name, %w[X O][key - 1], @game_board)
          break
        elsif human == 'N'
          @players[key] = @randomai.new(['!', '?'][key - 1], @game_board)
          break
        else
          puts "Sorry, I didn't understand that."
          break if testing
        end
      end
    end
  end

  def run_game
    @game_board = @board.new
    get_players

    current_player = @players[1]
    total_moves = 0

    loop do
      @game_board.render unless testing
      current_player.play_move

      break if @game_board.game_won?(current_player.symbol)

      total_moves += 1

      # The line below never triggers if the current player has won the game
      current_player = current_player == @players[1] ? @players[2] : @players[1]

      break if total_moves == 42
    end

    @game_board.render
    if total_moves < 42
      puts "\nThe winner is #{current_player.name}!\n"
    else
      puts "\nThe game is a tie!\n"
    end


    introduction unless testing
  end
end
