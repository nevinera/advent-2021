class Map
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def edge_pairs
    lines = @text.split("\n")
    lines.map { |line| line.split("-").map(&:strip) }
  end

  memoize def upper_nodes
    edges.keys.select { |n| n == n.upcase }
  end

  memoize def edges
    Hash.new.tap do |paths_from|
      edge_pairs.each do |a, b|
        paths_from[a] ||= []
        paths_from[a] << b
        paths_from[b] ||= []
        paths_from[b] << a
      end
    end
  end

  memoize def all_paths
    current_paths = [["start"]]
    terminal_paths = Set.new
    new_paths = []

    loop do
      return terminal_paths if current_paths.empty?

      current_paths.each do |path|
        next if terminal_paths.include?(path)

        tail = path.last

        next if tail == "end"

        potentials = edges[tail].select { |n| allowable?(path, n) }

        if potentials.empty?
          terminal_paths << path
        else
          potentials.each do |n|
            new_path = path + [n]
            if n == "end"
              terminal_paths << new_path
            else
              new_paths << new_path
            end
          end
        end
      end

      current_paths = new_paths
      new_paths = []
    end
  end

  def allowable?(path, node)
    return false if node == "start"
    return true if upper_nodes.include?(node)
    return true unless path.include?(node)

    # then only allowable if we haven't yet used our double-visit
    lowers = path.select { |p| p == p.downcase }
    lowers.count == lowers.uniq.count
  end

  memoize def paths
    all_paths.select { |p| p.last == "end" }
  end
end
