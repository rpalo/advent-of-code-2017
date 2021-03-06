# frozen_string_literal: true

# simulation of a spinlock.  Self generates by stepping and inserting.
class Spinlock
  attr_reader :current
  def initialize
    @elements = [0]
    @current = 0
    @next_insert = 1
  end

  def spin(step_size, step_qty)
    step_qty.times do |i|
      step(step_size)
      @elements.insert(@current + 1, @next_insert)
      @next_insert += 1
      step(1)
    end
  end

  def step(step_size)
    @current = (@current + step_size) % @next_insert
  end

  def [](ind)
    @elements[ind]
  end
end
