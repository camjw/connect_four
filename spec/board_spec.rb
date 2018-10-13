require 'board'

RSpec.describe Board do

  subject { described_class.new() }

  describe '#render' do
    it 'displays the entire board to the console' do

    end
  end

  describe '#move_valid?' do
    it 'returns true if a mode is valid' do
      expect(subject.move_valid?('2')).to eq true
    end

    it 'returns false if a move is not valid' do
      expect(subject.move_valid?('8')).to eq false
    end
  end

  describe '#play_move' do
    it 'adds a move to the board' do
      subject.play_move('1', 'X')
      updated_moves = subject.played_moves
      expected_moves = { '1' => ['X'], '2' => [], '3' => [], '4' => [],
        '5' => [], '6' => [], '7' => [] }
      updated_state = subject.board_state
      expected_state = [
       '|', '-', '-', '-', '-', '-', '-', '-', '|',
       '|', '-', '-', '-', '-', '-', '-', '-', '|',
       '|', '-', '-', '-', '-', '-', '-', '-', '|',
       '|', '-', '-', '-', '-', '-', '-', '-', '|',
       '|', '-', '-', '-', '-', '-', '-', '-', '|',
       '|', 'X', '-', '-', '-', '-', '-', '-', '|'
       ]
       expected_output = [expected_moves, expected_state]
      expect([updated_moves, updated_state]).to eq expected_output
    end
  end
end
