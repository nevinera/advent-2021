describe DiagnosticEntry do
  let(:bitstring) { "0110100" }
  subject(:entry) { described_class.new(bitstring) }

  describe "#bits" do
    subject(:bits) { entry.bits }
    it { is_expected.to eq([0, 1, 1, 0, 1, 0, 0]) }
  end

  describe "#to_i" do
    subject(:to_i) { entry.to_i }
    it { is_expected.to eq(52) }
  end

  describe "#to_s" do
    subject(:to_s) { entry.to_s }
    it { is_expected.to eq(bitstring) }
  end
end
