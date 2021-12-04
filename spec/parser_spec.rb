describe Parser do
  before do
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:read).with(path).and_return(content)
  end

  let(:path) { "/fake/path" }
  subject(:parser) { described_class.new(path) }

  describe "#lines" do
    subject(:lines) { parser.lines }

    context "when file is empty" do
      let(:content) { "" }
      it { is_expected.to be_empty }
    end

    context "when file has content" do
      let(:content) { "aaa\nbbb\nccc\n" }
      it { is_expected.to eq(["aaa", "bbb", "ccc"]) }
    end

    context "when lines have whitespace at the edges" do
      let(:content) { " aaa  \nbbb   \n\nccc" }
      it { is_expected.to eq(["aaa", "bbb", "ccc"]) }
    end
  end

  describe "#numbers" do
    subject(:numbers) { parser.numbers }

    context "when the file is empty" do
      let(:content) { "" }
      it { is_expected.to be_empty }
    end

    context "when the file has numbers in it" do
      let(:content) { "1\n2\n3\n4\n" }
      it { is_expected.to eq([1, 2, 3, 4]) }
    end
  end

  describe "#movements" do
    subject(:movements) { parser.movements }

    context "when the content is empty" do
      let(:content) { "" }
      it { is_expected.to eq([]) }
    end

    context "when there are some lines" do
      let(:content) { "up 1\ndown 2\nforward 3\n" }
      it { is_expected.to eq([["up", 1], ["down", 2], ["forward", 3]]) }
    end

    context "when those lines have random whitespace in them" do
      let(:content) { " up 1 \ndown 2\t \nforward 3\n" }
      it { is_expected.to eq([["up", 1], ["down", 2], ["forward", 3]]) }
    end
  end

  describe "#bingo" do
    subject(:bingo) { parser.bingo }

    let(:content) do
      <<~BINGO
        1,2,3,4,5

        10  1 18  9  7
         1 11 10 18  3
         1 11 10 18  3
         1 11 10 18  3
         1 11 10 18  3

        11  1 18  9  7
         1 11 10 18  3
         1 11 10 18  3
         1 11 10 18  3
         1 11 10 18  3
      BINGO
    end

    describe "calls" do
      subject(:calls) { bingo.first }
      it { is_expected.to eq([1, 2, 3, 4, 5]) }
    end

    describe "boards" do
      subject(:boards) { bingo.last }

      it { is_expected.to have_attributes(first: [
        [10, 1, 18, 9, 7],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
      ]) }

      it { is_expected.to have_attributes(last: [
        [11, 1, 18, 9, 7],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
        [1, 11, 10, 18, 3],
      ]) }
    end
  end
end
