# frozen_string_literal: true

# Self-replicating fractal art pattern
class Fractal
  def initialize(start_pattern, rule_text)
    @grid = gridify(start_pattern, "\n")
    initial_rules = rules_from_text(rule_text)
    @rules = flip_and_spin(initial_rules)
  end

  def iterate(count)
    count.times do
      portions, blocks_per_side = if @grid.size.even?
                                    subdivide(@grid, 2)
                                  else
                                    subdivide(@grid, 3)
                                  end
      converted = portions.map { |portion| @rules[portion] }
      @grid = join_grid(converted, blocks_per_side)
    end
  end

  def on
    @grid.flatten.count("#")
  end

  private

  def rules_from_text(text)
    text.lines.map do |line|
      start, finish = line.scan(/[\.#\/]+/)
      start_rule = gridify(start, "/")
      finish_rule = gridify(finish, "/")
      [start_rule.freeze, finish_rule.freeze]
    end.to_h
  end

  def gridify(phrase, line_sep)
    phrase.split(line_sep).map(&:chars)
  end

  def subdivide(grid, block_size)
    result = []
    blocks_per_side = grid.size / block_size
    blocks_per_side.times do |row_start|
      blocks_per_side.times do |col_start|
        result << get_block(grid, row_start, col_start, block_size)
      end
    end
    [result, blocks_per_side]
  end

  def get_block(grid, row_start, col_start, block_size)
    this_block = []
    block_size.times do |row|
      this_block << grid[
        block_size * row_start + row][
        block_size * col_start, block_size]
    end
    this_block
  end

  def join_grid(blocks, blocks_per_side)
    size = blocks.first.size
    gridsize = size * blocks_per_side
    result = Array.new(gridsize) { Array.new(gridsize, nil) }
    blocks.each.with_index do |block, ind|
      row_start = (ind / blocks_per_side).floor
      col_start = ind % blocks_per_side
      block.each.with_index do |row, row_ind|
        row.each.with_index do |item, col_ind|
          result[size * row_start + row_ind][size * col_start + col_ind] = item
        end
      end
    end
    result
  end

  # Returns every possible orientation of the initial rules provided
  def flip_and_spin(initial)
    results = {}
    initial.each do |in_rule, out_rule|
      all_orientations = four_orientations(in_rule) +
                         four_orientations(flip(in_rule))
      all_orientations.each { |rule| results[rule] = out_rule }
    end
    results
  end

  def four_orientations(grid)
    current_grid = grid
    result = [current_grid]
    3.times do
      current_grid = rotate_ccw(current_grid)
      result << current_grid
    end
    result
  end

  def rotate_ccw(grid)
    first, *rest = grid
    first.zip(*rest).reverse.freeze
  end

  def flip(grid)
    grid.map(&:reverse).freeze
  end
end
