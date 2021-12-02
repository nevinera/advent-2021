class Parser
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def numbers
    @_numbers ||= lines.map(&:strip).map(&:to_i)
  end

  def movements
    lines.map do |line|
      dir, dist_string = line.strip.split(/\s+/).map(&:strip)
      [dir, dist_string.to_i]
    end
  end

  private

  def content
    @_content ||= File.read(path)
  end

  def lines
    @_lines ||= content.split("\n").reject { |ln| ln.empty? }
  end
end
