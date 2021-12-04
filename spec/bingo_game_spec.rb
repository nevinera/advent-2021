describe BingoGame do
  let(:boards) { [board_a, board_b, board_c] }

  let(:board_a) do
    BingoBoard.new([
      [1, 2, 3, 4, 5],
      [6, 7, 8, 9, 10],
      [11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20],
      [21, 22, 23, 24, 25],
    ])
  end

  let(:board_b) do
    BingoBoard.new([
      [7, 2, 3, 4, 5],
      [6, 1, 8, 22, 10],
      [11, 12, 13, 14, 24],
      [16, 17, 18, 19, 20],
      [21, 9, 23, 15, 26],
    ])
  end

  let(:board_c) do
    BingoBoard.new([
      [1, 2, 10, 4, 16],
      [6, 7, 8, 9, 5],
      [11, 12, 13, 14, 15],
      [5, 17, 18, 19, 20],
      [21, 22, 23, 24, 27],
    ])
  end

  subject(:game) { described_class.new(boards) }

  describe "#winner" do
    subject(:winner) { game.winner(calls) }

    context "when the game is too short and nobody wins" do
      let(:calls) { [1, 2, 3, 4] }

      it "raises an argument error" do
        expect { winner }.to raise_error(ArgumentError, /No winner found/)
      end
    end

    context "when two boards win on the same call" do
      let(:calls) { [24, 15, 14, 13, 12, 11] }

      it "raises an argument error" do
        expect { winner }.to raise_error(ArgumentError, /Multiple winners/)
      end
    end

    context "when one board wins" do
      let(:calls) { [7, 1, 13, 19, 20, 26] }
      it { is_expected.to eq(board_b) }
    end
  end
end
