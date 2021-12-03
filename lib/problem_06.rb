class Problem06
  def initialize(path)
    @path = path
  end

  def answer
    report.oxygen_generator_rating.to_i * report.co2_scrubber_rating.to_i
  end

  def report
    DiagnosticReport.new(strings)
  end

  private

  def strings
    Parser.new(@path).lines
  end
end

