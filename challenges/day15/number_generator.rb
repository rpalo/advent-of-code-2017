# frozen_string_literal: true

# Generates numbers for the number judge
class NumberGenerator
  DIVISOR = 2_147_483_647

  def initialize(start, factor)
    @gen = Enumerator.new do |y|
      num = start
      while true
        num = (num * factor) % DIVISOR
        y.yield num
      end
    end
  end

  def next
    @gen.next
  end

  def first(n = 1)
    @gen.first(n)
  end
end
