# frozen_string_literal: true

# Virus that systematically infects grid system
class Virus
  attr_reader :infections
  attr_accessor :facing, :current

  Point = Struct.new(:row, :col) do
    def +(other)
      Point.new(row + other.row, col + other.col)
    end
    
    def *(const)
      Point.new(row * const, col * const)
    end
  end

  NORTH = Point.new(-1, 0)
  EAST = Point.new(0, 1)
  SOUTH = Point.new(1, 0)
  WEST = Point.new(0, -1)
  DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  def initialize(start_map)
    @grid = start_map.split("\n").map(&:chars)
    center = (@grid.size / 2).floor
    @current = Point.new(center, center)
    pad_healthy(10)
    @infections = 0
    @facing = NORTH
  end

  def cycle(count)
    count.times do
      case current_node
      when "#"
        turn_right
        flag!
      when "F"
        turn_around
        clean!
      when "W"
        infect!
        @infections += 1
      when "."
        turn_left
        weaken!
      end
      move_forward
      pad_healthy(5) if off_grid?
    end
  end

  private

  def current_node
    @grid[@current.row][@current.col]
  end

  def infected?
    @grid[@current.row][@current.col] == "#"
  end

  def turn_right
    @facing = DIRECTIONS[(DIRECTIONS.index(@facing) + 1) % DIRECTIONS.size]
  end

  def turn_left
    @facing = DIRECTIONS[(DIRECTIONS.index(@facing) - 1) % DIRECTIONS.size]
  end

  def turn_around
    @facing *= -1
  end

  def move_forward
    @current += @facing
  end

  def clean!
    @grid[@current.row][@current.col] = "."
  end

  def weaken!
    @grid[@current.row][@current.col] = "W"
  end

  def flag!
    @grid[@current.row][@current.col] = "F"
  end

  def infect!
    @grid[@current.row][@current.col] = "#"
  end

  def pad_healthy(amount)
    new_size = @grid.size + 2 * amount
    @grid = Array.new(amount) { Array.new(new_size, ".") } +
            @grid.map do |row|
              Array.new(amount, ".") + row + Array.new(amount, ".")
            end +
            Array.new(amount) { Array.new(new_size, ".") }
    @current += Point.new(amount, amount)
  end

  def off_grid?
    !((0...@grid.size).cover?(@current.row) &&
      (0...@grid.size).cover?(@current.col))
  end

  def print_grid
    output = @grid.dup
    puts "=============="
    puts output.map(&:join).join("\n")
    puts "=============="
  end
end
