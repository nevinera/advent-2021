describe DiagnosticReport do
  let(:strings) { ["010", "110", "100"] }
  subject(:report) { described_class.new(strings) }

  it "does not allow bitstrings of varying lengths" do
    expect { described_class.new(["00001", "100"]) }.to raise_error(ArgumentError, /don't match/)
  end

  describe "#entries" do
    subject(:entries) { report.entries }
    it { is_expected.to have_attributes(count: 3) }

    it "contains the expected DiagnosticEntries" do
      report.entries.each do |entry|
        expect(entry).to be_a(DiagnosticEntry)
      end

      expect(report.entries.map(&:to_s)).to eq(strings)
    end
  end

  describe "#gamma_rate" do
    subject(:gamma_rate) { report.gamma_rate }

    context "when all bits have a most common value" do
      let(:strings) { ["010", "110", "111"] }
      it { is_expected.to have_attributes(to_s: "110") }
    end

    context "when some bit has no most-common value" do
      let(:strings) { ["010", "000"] }

      it "raises an ArgumentError" do
        expect { gamma_rate }.to raise_error(ArgumentError, /Underspecified/)
      end
    end
  end

  describe "#epsilon_rate" do
    subject(:epsilon_rate) { report.epsilon_rate }

    context "when all bits have a least common value" do
      let(:strings) { ["010", "110", "111"] }
      it { is_expected.to have_attributes(to_s: "001") }
    end

    context "when some bit has no least-common value" do
      let(:strings) { ["010", "000"] }

      it "raises an ArgumentError" do
        expect { epsilon_rate }.to raise_error(ArgumentError, /Underspecified/)
      end
    end
  end

  describe "#power_consumption" do
    let(:strings) { ["010", "110", "111"] }
    subject(:power_consumption) { report.power_consumption }
    it { is_expected.to eq(6) }
  end
end
