describe Parser do
  before do
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:read).with(path).and_return(content)
  end

  let(:path) { "/fake/path" }
  subject(:parser) { described_class.new(path) }

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
end
