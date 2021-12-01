describe IncreaseFinder do
  subject(:increase_finder) { described_class.new(values) }

  describe "#increasing_pairs" do
    subject(:increasing_pairs) { increase_finder.increasing_pairs }

    context "when the array is empty" do
      let(:values) { [] }
      it { is_expected.to be_empty }
    end

    context "when the array is always increasing" do
      let(:values) { [1, 2, 3, 4] }
      it { is_expected.to eq([[1, 2], [2, 3], [3, 4]]) }
    end

    context "when the array varies" do
      let(:values) { [1, 5, 4, 5, 2] }
      it { is_expected.to eq([[1, 5], [4, 5]]) }
    end

    context "when the array contains adjacent matching values" do
      let(:values) { [1, 2, 2, 2, 3] }

      it "does not include those pairs" do
        expect(increasing_pairs).not_to include([2, 2])
      end
    end

    context "when the array is long" do
      let(:values) { [1, 5, 3, 5, 1, 2, 22, 5, 2, 2, 3, 9, 11, 8, 9, 10, 9] }

      it "only includes pairs that are increasing" do
        increasing_pairs.each do |a, b|
          expect(b).to be > a
        end
      end
    end
  end
end
