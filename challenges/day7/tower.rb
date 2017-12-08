# frozen_string_literal: true

# A weighted recursive tower
class Tower
  attr_accessor :parent, :children
  attr_reader :name

  def initialize(name)
    @parent = nil
    @children = []
    @name = name
  end
end
