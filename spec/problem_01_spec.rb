describe Problem01 do
  let(:fixture_path) { File.expand_path("../fixtures/depth-increases.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(7) }
  end
end
