# frozen_string_literal: true

# A weighted recursive tower
class Tower
  attr_accessor :parent, :children
  attr_reader :name, :weight

  def initialize(name, weight)
    @parent = nil
    @children = []
    @name = name
    @weight = weight
  end

  def total_weight
    @weight + @children.sum { |child| child.total_weight }
  end

  def ==(other)
    unless other.class == Tower
      raise ArgumentError, "Can't compare Tower with #{other.class}"
    end

    other.name == @name && other.weight == @weight
  end
end
