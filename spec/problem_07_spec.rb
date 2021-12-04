describe Problem07 do
  let(:fixture_path) { File.expand_path("../fixtures/bingo.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(4512) }
  end

  describe "#winner" do
    subject(:winner) { problem.winner}
    it { is_expected.to eq(problem.boards.last) }
  end
end

