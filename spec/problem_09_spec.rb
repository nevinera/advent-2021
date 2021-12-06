describe Problem09 do
  let(:fixture_path) { File.expand_path("../fixtures/segments.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(5) }
  end

  describe "#magnitude_grid" do
    subject(:grid) { problem.grid }

    it "looks as expected" do
      expect(grid).to eq(<<~MAGNITUDE)
        .......1..
        ..1....1..
        ..1....1..
        .......1..
        .112111211
        ..........
        ..........
        ..........
        ..........
        222111....
      MAGNITUDE
    end
  end
end

