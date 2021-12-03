describe Problem06 do
  let(:fixture_path) { File.expand_path("../fixtures/bitstrings.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(230) }
  end

  describe "#report" do
    subject(:report) { problem.report }

    it "has the expected oxygem_generator_rating" do
      expect(report.oxygen_generator_rating.to_i).to eq(23)
      expect(report.oxygen_generator_rating.to_s).to eq("10111")
    end

    it "has the expected co2_scrubber_rating" do
      expect(report.co2_scrubber_rating.to_i).to eq(10)
      expect(report.co2_scrubber_rating.to_s).to eq("01010")
    end
  end
end
