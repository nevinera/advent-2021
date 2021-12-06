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

  describe "#diagonal?" do
    subject(:diagonal?) { segment.diagonal? }

    context "up and right" do
      let(:point_b) { Point.new(6, 11) }
      it { is_expected.to be_truthy }
    end

    context "down and right" do
      let(:point_b) { Point.new(6, 7) }
      it { is_expected.to be_truthy }
    end

    context "up and left" do
      let(:point_b) { Point.new(2, 11) }
      it { is_expected.to be_truthy }
    end

    context "down and left" do
      let(:point_b) { Point.new(2, 7) }
      it { is_expected.to be_truthy }
    end

    context "a point" do
      let(:point_b) { point_a }
      it { is_expected.to be_truthy }
    end

    context "not diagonal" do
      let(:point_b) { Point.new(0, 0) }
      it { is_expected.to be_falsey }
    end
  end

  describe "#crossed_points" do
    subject(:crossed_points) { segment.crossed_points }

    context "when the segment is diagonal" do
      let(:point_b) { Point.new(2, 11) }
      before { expect(segment).to be_diagonal }

      context "up and right" do
        let(:point_b) { Point.new(6, 11) }
        it { is_expected.to contain_exactly(Point.new(6, 11), Point.new(5, 10), Point.new(4, 9)) }
      end

      context "down and right" do
        let(:point_b) { Point.new(6, 7) }
        it { is_expected.to contain_exactly(Point.new(6, 7), Point.new(5, 8), Point.new(4, 9)) }
      end

      context "up and left" do
        let(:point_b) { Point.new(2, 11) }
        it { is_expected.to contain_exactly(Point.new(2, 11), Point.new(3, 10), Point.new(4, 9)) }
      end

      context "down and left" do
        let(:point_b) { Point.new(2, 7) }
        it { is_expected.to contain_exactly(Point.new(2, 7), Point.new(3, 8), Point.new(4, 9)) }
      end
    end

    context "when the segment is orthonormal" do
      before { expect(segment).to be_orthonormal }

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

    context "when segment is neither diagonal nor orthonormal" do
      it "raises an ArgumentError" do
        expect { crossed_points }.to raise_error(ArgumentError, /unsupported segment/)
      end
    end
  end

  describe "#==" do
    subject(:equals) { segment == other }

    context "when made from the same points in the same order" do
      let(:other) { Segment.new(point_a, point_b) }
      it { is_expected.to be_truthy }
    end

    context "when made from the same points in reverse order" do
      let(:other) { Segment.new(point_b, point_a) }
      it { is_expected.to be_truthy }
    end

    context "when made from different points" do
      let(:other) { Segment.from_coordinates(0, 0, 0, 0) }
      it { is_expected.to be_falsey }
    end
  end

  describe "#inspect" do
    subject(:inspect) { segment.inspect }
    it { is_expected.to eq("Segment{(4,9) -> (6,8)}") }
  end
end
