require_relative "board"
require_relative "randomai"
require "csv"

class Array
  def to_csv(csv_filename="output.csv")
    CSV.open(csv_filename, "wb") do |csv|
      csv << first.keys
      self.each do |hash|
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
    @players = {1 => RandomAI.new("!", @board), 2 => RandomAI.new("?", @board)}

    current_player = @players[1]
    total_moves = 0

    while true
      current_player.play_move
      if @board.game_won?(current_player.symbol)
        break
      end
      total_moves += 1

      # The line below never triggers if the current player has won the game
      current_player = current_player == @players[1] ? @players[2] : @players[1]

      if total_moves == 42
        break
      end

      game_state = @board.board_state.join("").tr("|", "")

      @states << game_state

    end

    return game_state

  end

  def search_states(total_games, increment)
    output_array = []
    start_time = Time.now

    total_games.times { | num |
      play_game
      if num % increment == 0 && num > 0
        @states.uniq!
        time_taken = (((Time.now - start_time) * 100 ).to_i ) / 100
        output_array << { "Games played" => num, "States found" => @states.size,
          "Time taken" => time_taken }
        puts "Found #{@states.size} states after #{num} games
          and #{time_taken} seconds."
      end
    }

    final_time = (((Time.now - start_time) * 100 ).to_i ) / 100
    output_array << { "Games played" => total_games,
      "States found" => @states.size, "Time taken" => final_time }
    output_array.to_csv(csv_filename="rss_output.csv")
    puts "Found #{@states.size} states in total after #{final_time} seconds."

  end

end

rss = RandomStateSearch.new
rss.search_states(1000000, 1000)
