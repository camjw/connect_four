# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/randomai'
require 'csv'

class Array
  def to_csv(csv_filename = 'output.csv')
    CSV.open(csv_filename, 'wb') do |csv|
      csv << first.keys
      each do |hash|
        csv << hash.values
      end
    end
  end
end

class RandomStateSearch
  def initialize
    @states = []
  end

  def play_game
    @board = Board.new
    @players = { 1 => RandomAI.new('!', @board), 2 => RandomAI.new('?', @board) }

    current_player = @players[1]
    total_moves = 0

    loop do
      current_player.play_move
      break if @board.game_won?(current_player.symbol)

      total_moves += 1

      current_player = current_player == @players[1] ? @players[2] : @players[1]

      break if total_moves == 42

      game_state = @board.board_state.join('').tr('|', '')

      @states << game_state
    end

    game_state
  end

  def search_states(total_games, increment, target_file = 'rss_output.csv')
    output_array = []
    start_time = Time.now

    total_games.times do |num|
      play_game
      next unless num % increment == 0 && num > 0

      @states.uniq!
      time_taken = ((Time.now - start_time) * 100.0).to_i / 100.0
      output_array << { 'Games played' => num, 'States found' => @states.size,
                        'Time taken' => time_taken }
      puts "Found #{@states.size} states after #{num} games
        and #{time_taken} seconds."
      output_array.to_csv(csv_filename = 'data/' + target_file)
    end

    @states.uniq!
    final_time = ((Time.now - start_time) * 100.0).to_i / 100.0
    output_array << { 'Games played' => total_games,
                      'States found' => @states.size, 'Time taken' => final_time }
    output_array.to_csv(csv_filename = 'data/' + target_file)
    puts "Found #{@states.size} states in total after #{final_time} seconds."
  end
end

rss = RandomStateSearch.new
rss.search_states(1_000_000, 50_000, target_file = 'rss_output.csv')
