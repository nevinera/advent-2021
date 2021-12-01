class Parser
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def numbers
    @_numbers ||= lines.map(&:strip).map(&:to_i)
  end

  private

  def content
    @_content ||= File.read(path)
  end

  def lines
    @_lines ||= content.split("\n")
  end
end
