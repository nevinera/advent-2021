module Snail
  def self.tree(x, depth: 0)
    if x.is_a?(Array)
      Node.pair(
        self.tree(x.first, depth: depth + 1),
        self.tree(x.last, depth: depth + 1),
        depth)
    else
      Node.value(x, depth)
    end
  end

  class Node
    attr_accessor :children, :value, :depth

    def self.value(x, depth)
      new(value: x, children: [], depth: depth)
    end

    def self.pair(x, y, depth)
      new(value: nil, children: [x, y], depth: depth)
    end

    def initialize(value:, children:, depth:)
      @value, @children, @depth = value, children, depth
    end

    def to_a
      if value
        value
      else
        children.map(&:to_a)
      end
    end

    def print(indent = "")
      if value
        puts indent + "Value(#{depth}): #{value}"
      else
        puts indent + "Pair(#{depth}):"
        children.each do |child|
          child.print(indent + "  ")
        end
      end
    end

    def explodable?
      depth >= 4 && children.any?
    end

    def splitable?
      value && value >= 10
    end

    def +(other)
      depth_first { |n| n.depth += 1 }
      other.depth_first { |n| n.depth += 1 }
      Node.pair(self, other, 0).reduce!
    end

    def reduce!
      loop do
        to_explode = first { |n| n.explodable? }
        to_split = first { |n| n.splitable? }

        if to_explode
          explode! to_explode
        elsif to_split
          split! to_split
        else
          return self
        end
      end
    end

    def depth_first(&block)
      children.first.depth_first(&block) if children.any?
      block.call(self)
      children.last.depth_first(&block) if children.any?
    end

    def value_nodes
      [].tap do |values|
        depth_first do |node|
          values << node unless node.value.nil?
        end
      end
    end

    def first(&block)
      depth_first do |node|
        return node if block.call(node)
      end
      nil
    end

    def explode!(node)
      lval, rval = node.children.map(&:value)
      node.children = []
      node.value = 0

      before, after = pivot(value_nodes, node)
      before.last.value += lval if before.any?
      after.first.value += rval if after.any?
      node
    end

    def split!(node)
      x = node.value
      lval, rval = (x / 2.0).truncate, (x / 2.0).ceil
      node.value = nil
      node.children = [
        Node.value(lval, node.depth + 1),
        Node.value(rval, node.depth + 1),
      ]
      node
    end

    def magnitude
      if value
        value
      else
        children.first.magnitude * 3 + children.last.magnitude * 2
      end
    end

    private

    def pivot(values, value)
      n = values.find_index(value)
      [values.slice(0, n), values.slice(n+ 1, values.length)]
    end
  end
end
