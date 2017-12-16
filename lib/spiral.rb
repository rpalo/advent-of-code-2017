# frozen_string_literal: true

# Calculates math for numerical spirals:
# 5 4 3
# 6 1 2
# 7 8 ->
module Spiral
  # Part 2: returns first number bigger than limit while constructing
  # a spiral where each number is the sum of all existing cells
  # around it the time of its creation
  # NOTE: spiral for this method only gets build cw instead of
  #       ccw like all the others.  Whoops :)
  def self.cumulative_spiral_number(limit)
    spiral = [
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0],
    ]
    size = 3
    insert_point = 1

    loop do
      # Fill in top row up to right side
      while insert_point <= size - 1
        next_num = add_neighbors(spiral, insert_point)
        return next_num if next_num > limit
        spiral[0][insert_point] = next_num
        insert_point += 1
      end

      spiral = rotate_ccw(spiral)

      # If this spiral layer is full, expand to the next layer
      if spiral[0][1] != 0
        spiral = add_layer(spiral)
        size += 2
      end

      insert_point = 1
      # Continue looping with the next side of the spiral
    end
  end

  # Part 1: calculates x dist + y dist from number
  # to "1" at spiral center
  def self.manhattan_distance(num)
    side = side_that_contains(num)
    center_of_side = (side.sum / side.size).floor
    dist_on_side = (center_of_side - num).abs
    dist_away_from_side = (side.size / 2).floor

    dist_on_side + dist_away_from_side
  end

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

  # Returns a range of numbers that contains the number required
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

  # Adds all current cells surrounding specified index in top row
  # Checks for cells that aren't there and counts them as 0
  def self.add_neighbors(grid, top_row_index)
    left = top_row_index.positive? ? grid[0][top_row_index - 1] : 0
    lower_left = top_row_index.positive? ? grid[1][top_row_index - 1] : 0
    lower_middle = grid[1][top_row_index]
    lower_right = grid[1][top_row_index + 1] || 0

    left + lower_left + lower_middle + lower_right
  end

  def self.rotate_ccw(grid)
    # This is tricky, but if you don't believe me,
    # try it out in irb.  zip/reverse is the same as ccw rotation
    first, *rest = grid
    first.zip(*rest).reverse
  end

  # Adds a layer of zeros around current grid and returns the new grid
  def self.add_layer(grid)
    size = grid[0].size

    [[0] * (size + 2)] +
      grid.map { |row| [0] + row + [0] } +
      [[0] * (size + 2)]
  end
end
