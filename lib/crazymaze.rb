# frozen_string_literal: true

require_relative 'jumpmaze'

# Part 2: Same as part 1, except if the number was 3 or more
# before the jump, then you reduce it by one instead of increasing
class CrazyMaze < JumpMaze
  def step
    offset = @points[@current]
    if offset >= 3
      @points[@current] -= 1
    else
      @points[@current] += 1
    end
    @steps += 1
    @current += offset
  end
end
