# frozen_string_literal: true

require 'set'
require_relative '../day10/knot_hash'

# A disk populated by a knot hash and key phrase
class Disk
  GRID_SIZE = 128

  def initialize(phrase)
    @rows = []
    (0...GRID_SIZE).each do |r|
      row_string = "#{phrase}-#{r}"
      hex = KnotHash.new.hash(row_string)
      bin = hex
            .hex
            .to_s(2)
            .rjust(128, '0')
            .chars
            .map(&:to_i)
      @rows << bin
    end
  end

  def used
    @rows.reduce(0) { |total, row| total + row.sum }
  end

  def group_count
    groups = []
    padded = [Array.new(GRID_SIZE + 1, 0)] + @rows.map { |row| [0] + row }
    padded.each.with_index do |row, i|
      row.each.with_index do |col, j|
        next if col.zero?
        up = groups.find { |group| group.include?("#{i - 1}-#{j}") }
        left = groups.find { |group| group.include?("#{i}-#{j - 1}") }
        if up && left
          groups << up + left + ["#{i}-#{j}"]
          groups.delete(up)
          groups.delete(left)
        elsif up
          up << "#{i}-#{j}"
        elsif left
          left << "#{i}-#{j}"
        else
          groups << Set.new(["#{i}-#{j}"])
        end
      end
    end
    groups.size
  end
end
