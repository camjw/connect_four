require_relative "board"
require_relative "randomai"


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

      @states << game_state unless @states.include?(game_state)

    end

    return game_state

  end

  def search_states(total_games, increment)

    total_games.times { | num |
      play_game
      if num % increment == 0 && num > 0
        puts "Found #{@states.size} states after #{num} games."
      end
    }

    puts "Found #{@states.size} states in total."

  end

end

rss = RandomStateSearch.new
rss.search_states(10000, 1000)
