# frozen_string_literal: true

require_relative '../day10/knot_hash'

# A disk populated by a knot hash and key phrase
class Disk
  GRID_SIZE = 128

  def initialize(phrase)
    @rows = []
    (0...GRID_SIZE).each do |r|
      row_string = "#{phrase}-#{r}"
      hex = KnotHash.new.hash(row_string)
      bin = hex.scan(/../).map do |pair|
        pair.hex.to_s(2).rjust(2, '0')
      end
        .join
      @rows << bin
    end
  end

  def used
    @rows.reduce(0) { |total, row| total + row.chars.map(&:to_i).sum }
  end
end
