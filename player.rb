class Player

  attr_reader :name, :symbol

  def initialize(name, symbol)

    @name = name
    @symbol = symbol

  end

end

class RandomAI

  attr_reader :name, :symbol

  def initialize

    @name = "Random"
    @symbol = "?"

  end

  def select_move

    return 1 + rand(7)

  end

end
