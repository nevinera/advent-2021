describe Problem03 do
  let(:fixture_path) { File.expand_path("../fixtures/movements.txt", __FILE__) }
  subject(:problem) { described_class.new(fixture_path) }

  describe "#answer" do
    subject(:answer) { problem.answer }
    it { is_expected.to eq(150) }
  end
end

