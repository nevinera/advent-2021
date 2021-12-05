describe Point do
  let(:x) { 5 }
  let(:y) { 7 }
  subject(:point) { described_class.new(x, y) }

  describe "#coords" do
    subject(:coords) { point.coords }
    it { is_expected.to eq([5, 7]) }
  end

  describe "#==" do
    let(:other) { described_class.new(other_x, other_y) }
    subject(:equals) { point == other }

    context "when x differs" do
      let(:other_x) { x + 1 }

      context "when y differs" do
        let(:other_y) { y - 1 }
        it { is_expected.to be_falsey }
      end

      context "when y matches" do
        let(:other_y) { y }
        it { is_expected.to be_falsey }
      end
    end

    context "when x matches" do
      let(:other_x) { x }

      context "when y differs" do
        let(:other_y) { y - 1 }
        it { is_expected.to be_falsey }
      end

      context "when y matches" do
        let(:other_y) { y }
        it { is_expected.to be_truthy }
      end
    end
  end
end
