require 'player'

RSpec.describe Player do

  let(:mock_board) { double :mock_board, move_valid?: true }

  subject { described_class.new('Test', 'X', mock_board)}

  describe '#play_move' do

  end
end
