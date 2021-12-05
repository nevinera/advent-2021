describe VentField do
  subject(:field) { described_class.new }

  describe "#add_segment" do
    let(:segment_horizontal) { Segment.from_coordinates(1, 2, 4, 2) }

    it "adds the segment to the list" do
      expect { field.add_segment(segment_horizontal) }
        .to change(field, :segments)
        .from([])
        .to([segment_horizontal])
    end

    it "adds the points in the segment to the magnitudes" do
      expect { field.add_segment(segment_horizontal) }.to change(field, :magnitudes).from({})
      expect(field.magnitudes).to eq({
       [1, 2] => 1,
       [2, 2] => 1,
       [3, 2] => 1,
       [4, 2] => 1,
      })
    end

    context "when there are already segments added" do
      before { field.add_segment(segment_horizontal) }
      let(:segment_vertical) { Segment.from_coordinates(2, 1, 2, 3) }

      it "adds the segment to the list" do
        expect { field.add_segment(segment_vertical) }
          .to change(field, :segments)
          .from([segment_horizontal])
          .to([segment_horizontal, segment_vertical])
      end

      it "adds the points to the magnitude correctly" do
        expect { field.add_segment(segment_vertical) }
          .to change { field.magnitudes.length }.by(2)
        expect(field.magnitudes).to eq({
         [1, 2] => 1,
         [2, 2] => 2,
         [3, 2] => 1,
         [4, 2] => 1,
         [2, 1] => 1,
         [2, 3] => 1,
        })
      end
    end

    context "when the segment is diagonal" do
      let(:segment_diagonal) { Segment.from_coordinates(1, 1, 2, 2) }

      it "raises an ArgumentError" do
        expect { field.add_segment(segment_diagonal) }
          .to raise_error(ArgumentError, /orthonormal segments only/i)
      end
    end
  end

  describe "#magnitude_grid" do
    subject(:grid) { field.magnitude_grid }

    before do
      field.add_segment(Segment.from_coordinates(0, 0, 0, 3))
      field.add_segment(Segment.from_coordinates(2, 1, 2, 3))
      field.add_segment(Segment.from_coordinates(3, 2, 1, 2))
    end

    it "looks like expected" do
      expect(grid).to eq(<<~GRID)
        1...
        1.1.
        1121
        1.1.
      GRID
    end
  end
end
