require "set"

class Chunks
  extend Memoist

  MAPPING = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
  }

  OPENINGS = MAPPING.keys.to_set
  CLOSINGS = MAPPING.values.to_set

  def initialize(line)
    @line = line
    @stack = []
  end

  # return true if complete, false if incomplete, raise ParseError if corrupt
  memoize def process_line
    @line.chars.each do |char|
      if OPENINGS.include?(char)
        @stack.push(char)
      elsif CLOSINGS.include?(char)
        expected = MAPPING.fetch(@stack.pop)
        unless expected == char
          raise ParseError.new(char, "unexpected closing character encountered")
        end
      end
    end

    @stack.empty?
  end

  memoize def missing
    process_line
    @stack.reverse.map { |c| MAPPING.fetch(c) }
  end

  MISSING_VALUE = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }

  memoize def missing_score
    missing.reduce(0) { |total, c| total * 5 + MISSING_VALUE.fetch(c) }
  end

  class ParseError < StandardError
    attr_reader :encountered

    SCORES = {
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137,
    }

    def initialize(encountered, message)
      @encountered = encountered
      super(message)
    end

    def score
      SCORES.fetch(encountered, 0)
    end
  end
end
