class Octopus
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def starting
    lines = @text.split("\n").map(&:strip)
    values = lines.map { |line| line.chars.map(&:to_i) }

    h = {}
    values.each_with_index do |row, y|
      row.each_with_index do |value, x|
        h[[x, y]] = value
      end
    end

    h
  end

  memoize def step(n)
    return [starting, 0] if n == 0

    prior, count = step(n - 1)
    pending, new_count = next_after(prior, count)

    if new_count - count == starting.size
      puts "Step #{n} flashed all of the octopuses"
    end

    [pending, new_count]
  end

  def next_after(values, flash_count)
    already_flashed = Set.new
    next_values = values.dup.transform_values { |v| v + 1 }

    loop do
      high_pairs = next_values.select { |_coords, val| val > 9 }.keys.to_set
      new_flashes = high_pairs - already_flashed
      break if new_flashes.empty?

      new_flashes.each do |x, y|
        adjacent(x, y).each do |pair|
          next_values[pair] += 1 if next_values.key?(pair)
        end
        already_flashed << [x, y]
      end
    end

    next_values.transform_values! { |v| v > 9 ? 0 : v }
    [next_values, already_flashed.size + flash_count]
  end

  def adjacent(x, y)
    [
      [x-1, y-1],
      [x-1, y],
      [x-1, y+1],
      [x, y-1],
      [x, y+1],
      [x+1, y-1],
      [x+1, y],
      [x+1, y+1],
    ]
  end
end
