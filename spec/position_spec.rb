describe Position do
  subject(:position) { described_class.new }

  it "has the appropriate initial depth and horizontal" do
    expect(position.depth).to eq(0)
    expect(position.horizontal).to eq(0)
  end

  describe "#move" do
    it "handles 'forward' instructions correctly" do
      expect { position.move("forward", 3) }
        .to change { [position.horizontal, position.depth] }
        .to([3, 0])
    end

    it "handles 'down' instructions correctly" do
      expect { position.move("down", 3) }
        .to change { [position.horizontal, position.depth] }
        .to([0, 3])
    end

    it "handles 'up' instructions correctly" do
      expect { position.move("up", 3) }
        .to change { [position.horizontal, position.depth] }
        .to([0, -3])
    end
  end

  describe "#move_all" do
    let(:movements) { [["up", 3], ["forward", 2], ["down", 1], ["forward", 1]] }

    it "processes each instruction in order" do
      position.move_all(movements)
      expect(position.depth).to eq(-2)
      expect(position.horizontal).to eq(3)
    end
  end
end
