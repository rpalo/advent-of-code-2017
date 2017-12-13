# frozen_string_literal: true

class KnotHash
  def initialize(limit)
    @elements = (0..limit).to_a
  end

  def twist(*lengths)
    # pass
  end

  def [](ind)
    @elements[ind]
  end
end
