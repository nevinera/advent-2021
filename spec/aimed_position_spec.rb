describe AimedPosition do
  subject(:position) { described_class.new }

  it "has the appropriate initial depth and horizontal" do
    expect(position.aim).to eq(0)
    expect(position.depth).to eq(0)
    expect(position.horizontal).to eq(0)
  end

  describe "#move" do
    subject(:move) { -> { position.move(direction, distance) } }
    let(:distance) { 2 }

    context "with a forward instruction" do
      let(:direction) { "forward" }

      context "when aim is zero" do
        let(:position) { described_class.new(aim: 0) }
        it { is_expected.not_to change(position, :aim).from(0) }
        it { is_expected.not_to change(position, :depth).from(0) }
        it { is_expected.to change(position, :horizontal).from(0).to(2) }
      end

      context "when aim is -3" do
        let(:position) { described_class.new(aim: -3) }
        it { is_expected.not_to change(position, :aim).from(-3) }
        it { is_expected.to change(position, :depth).from(0).to(-6) }
        it { is_expected.to change(position, :horizontal).from(0).to(2) }
      end

      context "when aim is +2" do
        let(:position) { described_class.new(aim: 2) }
        it { is_expected.not_to change(position, :aim).from(2) }
        it { is_expected.to change(position, :depth).from(0).to(4) }
        it { is_expected.to change(position, :horizontal).from(0).to(2) }
      end
    end

    context "with an up instruction" do
      let(:direction) { "up" }
      it { is_expected.to change(position, :aim).by(-1 * distance) }
      it { is_expected.not_to change(position, :depth) }
      it { is_expected.not_to change(position, :horizontal) }
    end

    context "with a down instruction" do
      let(:direction) { "down" }
      it { is_expected.to change(position, :aim).by(distance) }
      it { is_expected.not_to change(position, :depth) }
      it { is_expected.not_to change(position, :horizontal) }
    end
  end

  describe "#move_all" do
    subject(:move_all) { -> { position.move_all(movements) } }
    let(:movements) { [["up", 3], ["forward", 2], ["down", 1], ["forward", 1]] }

    it { is_expected.to change(position, :aim).from(0).to(-3 + 1) }
    it { is_expected.to change(position, :horizontal).from(0).to(3) }
    it { is_expected.to change(position, :depth).from(0).to((-3 * 2) + (-2 * 1)) }
  end
end
