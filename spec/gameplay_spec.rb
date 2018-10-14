# frozen_string_literal: true

require 'gameplay'

RSpec.describe Gameplay do

  let(:mock_player_class) { double :mock_player_class, new: mock_player }
  let(:mock_player) { double :mock_player, play_move: '1', symbol: 'X', name: 'test' }
  let(:mock_random_class) { double :mock_random_class, new: mock_random }
  let(:mock_random) { double :mock_random }
  let(:mock_board_class) { double :mock_board_class, new: mock_board }
  let(:mock_board) { double :mock_board, render: true, game_won?: true, total_moves: 0 }
  let(:mock_board_class_draw) { double :mock_board_class_draw, new: mock_board_draw }
  let(:mock_board_draw) { double :mock_board, render: true, game_won?: false, total_moves: 42 }

  subject { described_class.new(board: mock_board_class, player: mock_player_class, randomai: mock_random_class, testing: true) }

  after do
    $stdin = STDIN
  end

  describe '#start' do
    it 'greets the player on instantiation' do
      expect { subject.start }.to output("Welcome to Connect Four!\n\n").to_stdout
    end
  end

  describe '#introduction' do
    it 'outputs goodbye if the player does not want to play' do
      $stdin = StringIO.new('N')
      n_message = "Would you like to play a new game? (Y/n)\nGoodbye!\n"
      expect { subject.introduction }.to output(n_message).to_stdout
    end

    it 'runs the game if the player does want to play' do
      $stdin = StringIO.new('Y')
      expect(subject).to receive(:run_game)
      subject.introduction
    end

    it 'querys the user if they input an unknown command' do
      $stdin = StringIO.new('T')
      t_message = "Would you like to play a new game? (Y/n)\n"\
                  "Sorry, I didn't understand that.\n"
      expect { subject.introduction }.to output(t_message).to_stdout
    end
  end

  describe '#get_players' do
    it 'asks whether the players are human' do
      allow(STDIN).to receive(:gets).and_return('N')
      expect { subject.get_players }.to output("Is Player 1 human? (Y/n)\nIs Player 2 human? (Y/n)\n").to_stdout
    end

    it 'makes human players if the players are human' do
      allow(STDIN).to receive(:gets).and_return('Y')
      subject.get_players
      expect(subject.players).to eq({ 1 => mock_player, 2 => mock_player })
    end

    it 'informs the user if it did not understand the command' do
      allow(STDIN).to receive(:gets).and_return('T')
      expect { subject.get_players }.to output("Is Player 1 human? (Y/n)\nSorry, I didn't understand that.\nIs Player 2 human? (Y/n)\nSorry, I didn't understand that.\n").to_stdout
    end
  end

  describe '#run_game' do
    it 'runs a full game' do
      allow(STDIN).to receive(:gets).and_return('Y')
      full_game_message = "Is Player 1 human? (Y/n)\nPlayer 1, what is your "\
                          "name?\nIs Player 2 human? (Y/n)\nPlayer 2, what is"\
                          " your name?\n\nThe winner is test!\n"
      expect { subject.run_game }.to output(full_game_message).to_stdout
    end

    it 'knows if the game has ended in a draw' do
      subject_draw =  described_class.new(board: mock_board_class_draw, player: mock_player_class, randomai: mock_random_class, testing: true)
      allow(STDIN).to receive(:gets).and_return('Y')
      draw_message = "Is Player 1 human? (Y/n)\nPlayer 1, what is your name?"\
                     "\nIs Player 2 human? (Y/n)\nPlayer 2, what is your "\
                     "name?\n\nThe game is a tie!\n"
      expect { subject_draw.run_game }.to output(draw_message).to_stdout
    end

  end


end
