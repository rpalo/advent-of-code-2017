# frozen_string_literal: true

# A packet that travels through pipes
class Packet
  attr_reader :history, :steps

  Position = Struct.new(:row, :col) do
    def +(other)
      Position.new(row + other.row, col + other.col)
    end
  end

  SOUTH = Position.new(1, 0)
  EAST = Position.new(0, 1)
  NORTH = Position.new(-1, 0)
  WEST = Position.new(0, -1)
  DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  def initialize
    @direction = SOUTH
    @history = []
    @position = Position.new(0, 0)
    @steps = 1
  end

  def travel(packet_map)
    grid = packet_map.lines.map(&:chars)
    @position.col = packet_map.index('|')
    loop do
      if /[A-Z]/.match?(current_cell(grid))
        @history << current_cell(grid)
      end

      if can_move?(forward, grid)
        move(forward)
      elsif can_move?(left, grid)
        move(left)
        @direction = left
      elsif can_move?(right, grid)
        move(right)
        @direction = right
      else
        break
      end
    end
  end

  def current_cell(grid)
    grid[@position.row][@position.col]
  end

  def can_move?(direction, grid)
    new_pos = @position + direction
    cell = grid.dig(new_pos.row, new_pos.col)
    /[|\-+A-Z]/.match?(cell)
  end

  def forward
    @direction
  end

  def left
    left_ind = (DIRECTIONS.index(@direction) - 1) % DIRECTIONS.size
    DIRECTIONS[left_ind]
  end

  def right
    right_ind = (DIRECTIONS.index(@direction) + 1) % DIRECTIONS.size
    DIRECTIONS[right_ind]
  end

  def move(position)
    @steps += 1
    @position += position
  end
end
