describe Problem11 do
  let(:fixture_path) { File.expand_path("../fixtures/fishes.txt", __FILE__) }
  let(:period) { 80 }
  subject(:problem) { described_class.new(fixture_path, period) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(5934) }

    context "after 18 days" do
      let(:period) { 18 }
      it { is_expected.to eq(26) }
    end
  end
end

