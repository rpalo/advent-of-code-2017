# frozen_string_literal: true

# Self-replicating fractal art pattern
class Fractal
  def initialize(start_pattern, rules)
    @grid = gridify(start_pattern, "\n")
    initial_rules = rules.lines.map do |line|
      start, finish = line.scan(/[\.#\/]+/)
      start_rule = gridify(start, "/")
      finish_rule = gridify(finish, "/")
      [start_rule.freeze, finish_rule.freeze]
    end.to_h
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

  def subdivide(grid, size)
    result = []
    blocks_per_side = grid.size / size
    blocks_per_side.times do |row|
      blocks_per_side.times do |col|
        this_block = []
        size.times do |row_offset|
          this_block << grid[size * row + row_offset][size * col, size]
        end
        result << this_block
      end
    end
    [result, blocks_per_side]
  end

  def join_grid(blocks, blocks_per_side)
    size = blocks[0].size
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
      this_one = in_rule
      results[this_one] = out_rule
      3.times do
        this_one = rotate_ccw(this_one)
        results[this_one] = out_rule
      end
      this_one = flip(this_one)
      results[this_one] = out_rule
      3.times do
        this_one = rotate_ccw(this_one)
        results[this_one] = out_rule
      end
    end
    results
  end

  def rotate_ccw(grid)
    first, *rest = grid
    first.zip(*rest).reverse.freeze
  end

  def flip(grid)
    grid.map(&:reverse).freeze
  end

  def gridify(phrase, line_sep)
    phrase.split(line_sep).map(&:chars)
  end

  def on
    @grid.flatten.count("#")
  end
end
