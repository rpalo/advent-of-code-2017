# frozen_string_literal: true

# Generates numbers for the number judge
class NumberGenerator
  DIVISOR = 2_147_483_647

  def initialize(start, factor, picky_factor)
    @picky = picky_factor

    @gen = Enumerator.new do |y|
      num = start
      loop do
        num = (num * factor) % DIVISOR
        y.yield num
      end
    end
    
  end

  def next
    @gen.next
  end

  def picky_next
    num = @gen.next
    until (num % @picky).zero?
      num = @gen.next
    end
    num
  end

  def first(n = 1)
    @gen.first(n)
  end
end
