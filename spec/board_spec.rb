require 'board'

RSpec.describe Board do

  subject { described_class.new() }

  describe '#render' do
    it 'displays the entire board to the console' do
      expect { subject.render }.to output("|-------|\n"\
                                          "|-------|\n"\
                                          "|-------|\n"\
                                          "|-------|\n"\
                                          "|-------|\n"\
                                          "|-------|\n"\
                                          "-1234567-\n").to_stdout
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

  describe '#game_won?' do
    it 'returns false when no moves have been played' do
      expect(subject.game_won?('X')).to eq false
    end

    it 'returns true when there is a horizontal win' do
      (1..4).each do |index|
        subject.play_move(index.to_s, 'X')
      end
      expect(subject.game_won?('X')).to eq true
    end

    it 'returns true when there is a vertical win' do
      4.times do |index|
        subject.play_move('1', 'X')
      end
      expect(subject.game_won?('X')).to eq true
    end

    it 'returns true when there is a diagonal win' do
      (1..4).each do |column|
        column.times do |index|
          subject.play_move(column.to_s, '0')
        end
      end
      (1..4).each do |index|
        subject.play_move(index.to_s, 'X')
      end
      expect(subject.game_won?('X')).to eq true
    end
  end
end
