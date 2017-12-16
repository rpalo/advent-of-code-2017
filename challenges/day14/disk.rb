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
        if padded[i - 1][j] == 1 && padded[i][j - 1] == 1
          address_up = index_that_contains(groups, "#{i - 1}-#{j}")
          address_left = index_that_contains(groups, "#{i}-#{j - 1}")
          groups << groups[address_up] + groups[address_left] + ["#{i}-#{j}"]
          groups.select!.with_index { |item, index| index != address_up && index != address_left }
        elsif padded[i - 1][j] == 1
          address = index_that_contains(groups, "#{i - 1}-#{j}")
          groups[address] << "#{i}-#{j}"
        elsif padded[i][j - 1] == 1
          address = index_that_contains(groups, "#{i}-#{j - 1}")
          groups[address] << "#{i}-#{j}"
        else
          groups << Set.new(["#{i}-#{j}"])
        end
      end
    end
    # puts "\n" + padded.map { |row| row.first(30).join(", ") }.join("\n")
    groups.size
  end

  def index_that_contains(groups, item)
    groups.index { |group| group.include?(item) }
  end
end
