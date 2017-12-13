# frozen_string_literal: true

# A hashing algorithm based on twisting knots in string
class KnotHash
  def initialize(limit)
    @elements = (0..limit).to_a
    @size = limit + 1
  end

  def twist(*lengths)
    position = 0
    skip_size = 0
    flipstack = []
    lengths.each do |length|
      flipstack = get(position, length)
      while item = flipstack.pop
        @elements[position] = item
        position = (position + 1) % @size
      end
      position = (position + skip_size) % @size
      skip_size += 1
    end
  end

  def get(start, length)
    position = start
    results = []
    length.times do
      results << @elements[position]
      position = (position + 1) % @size
    end
    results
  end

  def [](ind)
    @elements[ind]
  end
end
