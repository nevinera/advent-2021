describe Problem05 do
  let(:fixture_path) { File.expand_path("../fixtures/bitstrings.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(198) }
  end

  describe "#report" do
    subject(:report) { problem.report }

    it "has the expected gamma_rate" do
      expect(report.gamma_rate.to_i).to eq(22)
      expect(report.gamma_rate.to_s).to eq("10110")
    end

    it "has the expected epsilon_rate" do
      expect(report.epsilon_rate.to_i).to eq(9)
      expect(report.epsilon_rate.to_s).to eq("01001")
    end
  end
end


