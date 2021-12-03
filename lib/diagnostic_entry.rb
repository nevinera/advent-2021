require "memoist"

class DiagnosticEntry
  extend Memoist

  def initialize(bit_string)
    @bit_string = bit_string
  end

  def bits
    @bit_string.chars.map(&:to_i)
  end

  def to_i
    @bit_string.to_i(2)
  end

  def to_s
    @bit_string
  end
end
