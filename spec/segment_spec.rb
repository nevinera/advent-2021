describe Segment do
  let(:point_a) { Point.new(4, 9) }
  let(:point_b) { Point.new(6, 8) }
  subject(:segment) { described_class.new(point_a, point_b) }

  describe ".from_coordinates" do
    subject(:segment) { described_class.from_coordinates(1, 2, 3, 4) }
    it { is_expected.to have_attributes(a: Point.new(1, 2)) }
    it { is_expected.to have_attributes(b: Point.new(3, 4)) }
  end

  describe "#orthonormal?" do
    subject(:orthonormal?) { segment.orthonormal? }

    context "when the segment is a point" do
      let(:point_b) { point_a }
      it { is_expected.to be_truthy }
    end

    context "when the segment is horizontal" do
      let(:point_b) { Point.new(15, point_a.y) }
      it { is_expected.to be_truthy }
    end

    context "when the segment is vertical" do
      let(:point_b) { Point.new(point_a.x, 15) }
      it { is_expected.to be_truthy }
    end

    context "when the segment is diagonal" do
      let(:point_b) { Point.new(point_a.x + 5, point_a.y + 5) }
      it { is_expected.to be_falsey }
    end
  end

  describe "#crossed_points" do
    subject(:crossed_points) { segment.crossed_points }

    context "when the segment is diagonal" do
      before { expect(segment).not_to be_orthonormal }

      it "raises an ArgumentError" do
        expect { crossed_points }.to raise_error(ArgumentError, /Orthonormal segments only/)
      end
    end

    context "when the segment is horizontal" do
      let(:point_b) { Point.new(6, 9) }
      it { is_expected.to contain_exactly(Point.new(4, 9), Point.new(5, 9), Point.new(6, 9)) }
    end

    context "when the segment is vertical" do
      let(:point_b) { Point.new(4, 7) }
      it { is_expected.to contain_exactly(Point.new(4, 7), Point.new(4, 8), Point.new(4, 9)) }
    end

    context "when the segment is a point" do
      let(:point_b) { point_a }
      it { is_expected.to contain_exactly(point_a) }
    end
  end
end
