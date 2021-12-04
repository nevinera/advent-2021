describe BingoBoard do
  let(:values) do
    [
      [1, 2, 3, 4, 5],
      [11, 12, 13, 14, 15],
      [21, 22, 23, 24, 25],
      [31, 32, 33, 34, 35],
      [41, 42, 43, 44, 2],
    ]
  end

  subject(:board) { described_class.new(values) }

  it "has the expected initial state" do
    expect(board.value(0, 0)).to eq(1)
    expect(board.value(2, 4)).to eq(25)
    expect(board.marked?(0, 0)).to be_falsey
    expect(board).not_to be_complete
  end

  describe "#mark" do
    subject(:mark) { -> { board.mark(target) } }

    context "when marking a value that isn't present" do
      let(:target) { 99 }
      it { is_expected.not_to change(board, :marked) }
    end

    context "when marking a value that is present" do
      let(:target) { 35 }
      it { is_expected.to change(board, :marked).from({}).to([3, 4] => true) }
    end

    context "when marking a value that is present multiple times" do
      let(:target) { 2 }
      it { is_expected.to change(board, :marked).from({}).to([0, 1] => true, [4, 4] => true) }
    end
  end

  describe "#complete?" do
    subject(:complete?) { board.complete? }

    def mark_all(*values)
      values.each { |value| board.mark(value) }
    end

    context "when no marks are present" do
      before { expect(board.marked).to be_empty }
      it { is_expected.to be_falsey }
    end

    context "when marks are present, but not in lines" do
      before { mark_all(1, 22, 13, 24, 25, 44) }
      it { is_expected.to be_falsey }
    end

    context "when a horizontal line is all marked" do
      before { mark_all(21, 22, 23, 24, 25) }
      it { is_expected.to be_truthy }
    end

    context "when a vertical line is all marked" do
      before { mark_all(5, 15, 25, 35, 2) }
      it { is_expected.to be_truthy }
    end

    context "when the down-diagonal is marked" do
      before { mark_all(1, 12, 23, 34, 2) }
      it { is_expected.to be_truthy }
    end

    context "when the up-diagonal is marked" do
      before { mark_all(41, 23, 32, 14, 5) }
      it { is_expected.to be_truthy }
    end

    context "when multiple lines are marked" do
      before { mark_all(1, 2, 3, 4, 5, 41, 32, 23, 14, 5) }
      it { is_expected.to be_truthy }
    end
  end
end
