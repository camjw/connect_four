# frozen_string_literal: true

require 'randomai'

RSpec.describe RandomAI do

  let(:mock_board_true) { double :mock_board, move_valid?: true, play_move: true }
  let(:mock_board_false) { double :mock_board, move_valid?: false, play_move: true }

  subject { described_class.new('?', mock_board_true) }

  describe '#play_move' do
    it 'plays a move when the move is valid' do
      srand(11)
      expect(mock_board_true).to receive(:play_move).with('1', '?')
      subject.play_move
    end

    it 'does not play a move when the move is invalid' do
      false_subject = described_class.new('!', mock_board_false)
      expect(mock_board_false).to_not receive(:play_move)
      false_subject.play_move
    end
  end
end
