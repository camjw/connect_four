# Connect Four

This repository is a Ruby implementation of the popular Connect Four game which you can play in your terminal. It supports two player games, a very dubious one player game and a surreal to watch zero player game.

## Example game
The game interface is simple: just enter numbers from 1 to 7 to indicate the column you want to play. The game won't allow invalid moves (i.e. if there are already seven pieces in a column or if you enter a string which is not a number from 1 to 7).

![How the game starts](images/start of game.png)

The winner is mildly congratulated:

![How the game ends](images/end of game.png)
## Usage

The four necessary classes are the `board`, `player`, `randomai`, and `gameplay` classes.

```ruby
require "gameplay"

game = Gameplay.new   # Starts a new game
```
