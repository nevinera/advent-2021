describe SlidingWindow do
  subject(:sliding_window) { described_class.new(values) }

  describe "#windows" do
    let(:values) { [1, 2, 3, 4, 5] }
    subject(:windows) { sliding_window.windows(size) }

    context "with size of 1" do
      let(:size) { 1 }
      it { is_expected.to eq([[1], [2], [3], [4], [5]]) }
    end

    context "with size of 2" do
      let(:size) { 2 }
      it { is_expected.to eq([[1, 2], [2, 3], [3, 4], [4, 5]]) }
    end

    context "with size of 3" do
      let(:size) { 3 }
      it { is_expected.to eq([[1, 2, 3], [2, 3, 4], [3, 4, 5]]) }
    end

    context "with size larger than the array" do
      let(:size) { 6 }
      it { is_expected.to be_empty }
    end
  end

  describe "#window_sums" do
    let(:values) { [1, 2, 3, 4, 5] }
    subject(:window_sums) { sliding_window.window_sums(size) }

    context "with size of 1" do
      let(:size) { 1 }
      it { is_expected.to eq([1, 2, 3, 4, 5]) }
    end

    context "with size of 2" do
      let(:size) { 2 }
      it { is_expected.to eq([3, 5, 7, 9]) }
    end

    context "with size of 3" do
      let(:size) { 3 }
      it { is_expected.to eq([6, 9, 12]) }
    end

    context "with size larger than the array" do
      let(:size) { 6 }
      it { is_expected.to be_empty }
    end
  end
end
