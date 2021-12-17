require "json"

class Bits
  extend Memoist
  attr_reader :hex_string

  def initialize(hex_string)
    @hex_string = hex_string
  end

  memoize def initial_bytes
    hex_to_bin(hex_string)
  end

  def consume_packet(bytes)
    puts "consuming a packet"
    p = Packet.new
    p.version = bin_to_int(shift(bytes, 3))
    p.type_id = bin_to_int(shift(bytes, 3))

    if p.type_id == 4
      puts "consuming a literal"
      p.value = consume_literal(bytes)
    else
      p.length_type = shift(bytes, 1).first
      if p.length_type == 0
        p.length = bin_to_int(shift(bytes, 15))
        puts "consuming #{p.length} bytes of packets"
        p.packets = consume_n_bytes(bytes, p.length)
      else
        p.length = bin_to_int(shift(bytes, 11))
        puts "consuming #{p.length} packets"
        p.packets = consume_n_packets(bytes, p.length)
      end
    end

    p
  end

  def consume_literal(bytes)
    output = []

    loop do
      continue_bit = shift(bytes, 1).first
      output += shift(bytes, 4)
      break unless continue_bit == 1
    end

    bin_to_int(output)
  end

  def consume_n_bytes(bytes, n)
    to_read = shift(bytes, n)

    packets = []
    while to_read.any?
      packets << consume_packet(to_read)
    end

    packets
  end

  def consume_n_packets(bytes, n)
    n.times.map do |n|
      consume_packet(bytes)
    end
  end

  def shift(bytes, n)
    result = bytes.shift(n)
    puts "took #{n} bytes, #{bin_to_s(result)}, leaving #{bin_to_s(bytes)}"
    fail("Ran out of bytes!") if result.length != n
    result
  end

  def hex_to_bin(p)
    hex_values = p.chars.map { |c| c.to_i(16) }
    binary_strings = hex_values.map { |n| n.to_s(2).rjust(4, "0") }
    binary_strings.map(&:chars).flatten.map(&:to_i)
  end

  def bin_to_int(b)
    b.map(&:to_s).join.to_i(2)
  end

  def bin_to_s(b)
    b.map(&:to_s).join
  end

  class Packet
    attr_accessor :version, :type_id, :value, :length_type, :length, :packets

    def initialize
      @packets = []
    end

    def to_h
      {
        version: version,
        type_id: type_id,
        value: value,
        length_type: length_type,
        length: length,
        packets: packets.any? ? packets.map(&:to_h) : nil,
      }.compact
    end

    def to_s
      to_h.to_json
    end
  end
end
