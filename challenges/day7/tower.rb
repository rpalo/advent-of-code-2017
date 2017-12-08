# frozen_string_literal: true

# A weighted recursive tower
class Tower
  attr_accessor :parent, :children
  attr_reader :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def base
    if @parent.nil?
      @value
    else
      @parent.base
    end
  end

  def self.build_from_string(text)
    tower_dict = {}
    text.each_line do |line|
      value = line.split.first
      tower_dict[value] = Tower.new(line.split.first)
    end
    children_match = /-> ([a-z]+(, [a-z]+)*)/
    text.each_line do |line|
      children = children_match.match(line).to_a[1]
      next if children.nil?

      parent = line.split.first
      children.split(", ").each do |child|
        tower_dict[child].parent = tower_dict[parent]
      end
    end
    tower_dict.values
  end
end
