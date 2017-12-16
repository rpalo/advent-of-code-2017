# frozen_string_literal: true

module Hexgrid

  Position = Struct.new(:x, :y) do
    def +(other)
      Position.new(x + other.x, y + other.y)
    end
  end

  def self.step(direction)
    case direction
    when "nw"
      Position.new(-1, 0.5)
    when "n"
      Position.new(0, 1)
    when "ne"
      Position.new(1, 0.5)
    when "sw"
      Position.new(-1, -0.5)
    when "s"
      Position.new(0, -1)
    when "se"
      Position.new(1, -0.5)
    else
      raise ArgumentError, "Can't process move #{step}"
    end
  end

  # Part 1: Final distance away
  def self.final_position(steps)
    pos = Position.new(0, 0)
    steps.each do |dir|
      pos += step(dir)
    end
    pos
  end

  def self.distance(pos)
    # If Y is bigger than X, then the algorithm is
    # "Go east/west until you are at the same x as the goal"
    # "Then go straight north/south."
    # If X is bigger, then we get the Y travel essentially for
    # free as we step in X, so we can ignore the y steps.
    # If that's the case, Y - X/2 will be negative.
    (pos.x.abs + [pos.y.abs - pos.x.abs / 2, 0].max).floor
  end

  # Part 2: Max distance away
  def self.max_distance(steps)
    pos = Position.new(0, 0)
    max_dist = 0
    steps.each do |dir|
      pos += step(dir)
      this_dist = distance(pos)
      max_dist = this_dist if this_dist > max_dist
    end
    max_dist
  end
end