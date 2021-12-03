class Problem05
  def initialize(path)
    @path = path
  end

  def answer
    report.power_consumption
  end

  def report
    DiagnosticReport.new(strings)
  end

  private

  def strings
    Parser.new(@path).lines
  end
end
