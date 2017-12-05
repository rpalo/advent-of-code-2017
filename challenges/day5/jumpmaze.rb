# frozen_string_literal: true

# Part 1: Jump through the maze the number of steps that the
# item your on says (e.g. if the item is 3, step 3 places forward)
# Count the number of steps to be outside the list.
class JumpMaze
  def initialize(points)
    @points = points.dup
    @_original = points.dup
    @current = 0
    @steps = 0
  end

  def step
    offset = @points[@current]
    @points[@current] += 1
    @steps += 1
    @current += offset
  end

  def reset
    @points = @_original.dup
    @current = 0
    @steps = 0
  end

  def steps_to_escape
    step until @current.negative? or @current > @points.size - 1
    @steps
  end
end