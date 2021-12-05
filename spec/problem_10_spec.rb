describe Problem10 do
  let(:fixture_path) { File.expand_path("../fixtures/segments.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(12) }
  end

  describe "#magnitude_grid" do
    subject(:grid) { problem.grid }

    it "looks as expected" do
      expect(grid).to eq(<<~MAGNITUDE)
        1.1....11.
        .111...2..
        ..2.1.111.
        ...1.2.2..
        .112313211
        ...1.2....
        ..1...1...
        .1.....1..
        1.......1.
        222111....
      MAGNITUDE
    end
  end
end

