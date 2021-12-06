describe Fishes do
  let(:initial_timers) { [1, 1, 2, 5, 6] }
  subject(:fishes) { described_class.new(initial_timers) }

  describe "#wait" do
    subject(:wait) { -> { fishes.wait(period) } }

    context "when period is 1" do
      let(:period) { 1 }
      it { is_expected.to change(fishes, :elapsed).by(1) }
      it { is_expected.to change(fishes, :totals) }
    end

    context "when period is longer" do
      let(:period) { 7 }
      it { is_expected.to change(fishes, :elapsed).by(7) }
      it { is_expected.to change(fishes, :totals) }
    end
  end

  describe "#step" do
    subject(:step) { -> { fishes.step } }

    context "when there are no fish about to give birth" do
      let(:initial_timers) { [1, 2, 1, 3] }
      let(:initial_totals) { [0, 2, 1, 1, 0, 0, 0, 0, 0, 0] }
      let(:step_totals) { [2, 1, 1, 0, 0, 0, 0, 0, 0, 0] }
      it { is_expected.to change(fishes, :totals).from(initial_totals).to(step_totals) }
      it { is_expected.to change(fishes, :elapsed).by(1) }
    end

    context "when there are fish about to give birth" do
      let(:initial_timers) { [1, 2, 1, 3, 0, 0, 5] }
      let(:initial_totals) { [2, 2, 1, 1, 0, 1, 0, 0, 0, 0] }
      let(:step_totals) { [2, 1, 1, 0, 1, 0, 2, 0, 2, 0] }
      it { is_expected.to change(fishes, :totals).from(initial_totals).to(step_totals) }
      it { is_expected.to change(fishes, :elapsed).by(1) }
    end
  end

  describe "#count" do
    subject(:count) { fishes.count }

    context "initially" do
      it { is_expected.to eq(5) }
    end

    context "after two fish have reproduced" do
      before { fishes.wait(2) }
      it { is_expected.to eq(7) }
    end
  end
end
