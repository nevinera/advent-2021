describe Problem04 do
  let(:fixture_path) { File.expand_path("../fixtures/movements.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(900) }
  end

  describe "#position" do
    before { problem.answer }
    subject(:position) { problem.position }

    it "has the expected depth and horizontal" do
      expect(position.depth).to eq(60)
      expect(position.horizontal).to eq(15)
    end
  end
end

