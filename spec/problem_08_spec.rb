describe Problem08 do
  let(:fixture_path) { File.expand_path("../fixtures/bingo.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(1924) }
  end

  describe "#loser" do
    subject(:loser) { problem.loser}
    it { is_expected.to eq(problem.boards[1]) }
  end
end

