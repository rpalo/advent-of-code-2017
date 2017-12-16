# frozen_string_literal: true

# A hashing algorithm based on twisting knots in string
class KnotHash
  TAIL = [17, 31, 73, 47, 23].freeze
  TWIST_COUNT = 64
  DENSE_SIZE = 16

  def initialize(limit = 255)
    @elements = (0..limit).to_a
    @size = limit + 1
    @position = 0
    @skip_size = 0
  end

  # Part 1: Twist the lengths according to specified algorithm
  def twist(*lengths)
    flipstack = []
    lengths.each do |length|
      flipstack = get(@position, length)
      while item = flipstack.pop
        @elements[@position] = item
        @position = advance(@position, 1)
      end
      @position = advance(@position, @skip_size)
      @skip_size += 1
    end
  end

  # Part 2: Get knot hash from bytes/chars
  def hash(str)
    bytes = str.chars.map(&:ord) + TAIL
    @position = 0
    @skip_size = 0
    TWIST_COUNT.times { twist(*bytes) }
    dense_hash = compress(@elements)
    hex(dense_hash)
  end

  def compress(numbers)
    numbers.each_slice(DENSE_SIZE).map do |group|
      group.reduce(0) { |total, num| total ^ num }
    end
  end

  def hex(numbers)
    numbers.map { |number| number.to_s(16).rjust(2, '0') }.join
  end

  def advance(current, amount)
    (current + amount) % @size
  end

  def get(start, length)
    position = start
    results = []
    length.times do
      results << @elements[position]
      position = advance(position, 1)
    end
    results
  end

  def [](ind)
    @elements[ind]
  end
end
