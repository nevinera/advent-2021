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
      puts "Encountered a #{char}"
      puts "   Stack: #{@stack.join}"
      if OPENINGS.include?(char)
        puts "   opening -> pushing #{char}"
        @stack.push(char)
      elsif CLOSINGS.include?(char)
        expected = MAPPING.fetch(@stack.pop)
        puts "   closing -> popping #{expected}"
        unless expected == char
          puts "      does not match"
          raise ParseError.new(char, "unexpected closing character encountered")
        else
          puts "      matches"
        end
      end
    end

    @stack.empty?
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
