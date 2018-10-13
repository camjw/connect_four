# frozen_string_literal: true

require 'player'

RSpec.describe Player do
  let(:mock_board_true) { double :mock_board, move_valid?: true, play_move: true }
  let(:mock_board_false) { double :mock_board, move_valid?: false, play_move: true }

  subject { described_class.new('Test', 'X', mock_board_true) }
  #
  # before do
  #   $stdout =
  # end

  after do
    $stdin = STDIN
  end

  describe '#play_move' do
    it 'tells the player it is their turn' do
      $stdin = StringIO.new('1')
      expect { subject.play_move }.to output("\nTest, it's your turn. Choose a "\
                                             "column from 1 to 7.\n").to_stdout
    end

    it 'plays a move on the board when the move is valid' do
      $stdin = StringIO.new('1')
      expect(mock_board_true).to receive(:play_move).with('1', 'X')
      subject.play_move
    end

    it 'does not play a move on the board when the move is invalid' do
      $stdin = StringIO.new('8')
      invalid_move_subject = described_class.new('Test', 'X', mock_board_false)
      expect(mock_board_false).to_not receive(:play_move)
      invalid_move_subject.play_move
    end
  end
end
