class DiagnosticReport
  extend Memoist

  def initialize(strings)
    @length = strings.first&.length || 0
    @strings = strings
    fail(ArgumentError, "strings don't match") unless @strings.all? { |s| s.length == @length }
  end

  memoize def entries
    @strings.map { |s| DiagnosticEntry.new(s) }
  end

  memoize def gamma_rate
    bits = (0...@length).map { |offset| most_common(entries, offset) }
    bit_string = bits.map(&:to_s).join
    DiagnosticEntry.new(bit_string)
  end

  memoize def epsilon_rate
    bits = (0...@length).map { |offset| least_common(entries, offset) }
    bit_string = bits.map(&:to_s).join
    DiagnosticEntry.new(bit_string)
  end

  memoize def power_consumption
    gamma_rate.to_i * epsilon_rate.to_i
  end

  private

  # 0-indexed
  memoize def most_common(entry_list, n)
    sum = entry_list.map { |e| e.bits[n] }.sum
    if sum * 2 > entry_list.length
      1
    elsif sum * 2 < entry_list.length
      0
    else
      fail ArgumentError, "Underspecified problem - result not clear when bits are equally common"
    end
  end

  memoize def least_common(entry_list, n)
    1 - most_common(entry_list, n)
  end
end
