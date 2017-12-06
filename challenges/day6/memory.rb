# frozen_string_literal: true

require 'set'

class Memory
  def initialize(banks)
    @banks = banks
    @seen = Set.new
  end

  def cycles_to_loop
    cycles = 0
    loop do
      cycles += 1
      redistribute
      if @seen.include?(@banks.join(''))
        break
      else
        @seen << @banks.join('')
      end
    end
    cycles
  end

  def redistribute
    starting = index_of_first_max
    blocks = @banks[starting]
    @banks[starting] = 0
    pointer = starting
    until blocks == 0
      pointer += 1
      @banks[pointer % @banks.size] += 1
      blocks -= 1
    end
  end

  def index_of_first_max
    @banks.index(@banks.max)
  end
end
