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
end
