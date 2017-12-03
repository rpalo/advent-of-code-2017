# Calculates math for numerical spirals:
# 5 4 3
# 6 1 2
# 7 8 ->
module Spiral

  def self.manhattan_distance(num)
    side = side_that_contains(num)
    center_of_side = (side.sum / side.size).floor
    dist_on_side = (center_of_side - num).abs
    dist_away_from_side = (side.size/2).floor

    dist_on_side + dist_away_from_side
  end

  private

  # Gets the bottom right number in the
  # spiral layer containing our number
  def self.bottom_right(num)
    bottom_right = 1
    n = 1
    while bottom_right < num
      n += 2
      bottom_right = n**2
    end
    [n, bottom_right]
  end

  def self.side_that_contains(num)
    side_length, biggest = bottom_right(num)
    bottom = (biggest - side_length + 1)..biggest
    left = (bottom.first - side_length + 1)..bottom.first
    top = (left.first - side_length + 1)..left.first
    right = (top.first - side_length + 2)..top.first
    # Right gets one less since it gets shorted.
    
    sides = [bottom, left, top, right]
    sides.find { |side| side.include?(num) }
  end
end