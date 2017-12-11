# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'hexgrid'

class TestHexgrid < Minitest::Test

  # Part 1: Final distance away
  def test_three_steps_away
    last_spot = Hexgrid.final_position(['ne', 'ne', 'ne'])
    assert_equal 3, Hexgrid.distance(last_spot)
  end

  def test_return_to_origin
    last_spot = Hexgrid.final_position(['ne', 'ne', 'sw', 'sw'])
    assert_equal 0, Hexgrid.distance(last_spot)
  end

  def test_partial_backtrack
    last_spot = Hexgrid.final_position(['ne', 'ne', 's', 's'])
    assert_equal 2, Hexgrid.distance(last_spot)
  end

  def test_zig_zag_south
    last_spot = Hexgrid.final_position(['se', 'sw', 'se', 'sw', 'sw'])
    assert_equal 3, Hexgrid.distance(last_spot)
  end

  def test_longer_example
    moves = "s,s,sw,se,s,nw,nw,ne,n,ne,n,n,n,n,n,n,n,ne,n,ne,ne".split(',')
    last_spot = Hexgrid.final_position(moves)
    assert_equal 10, Hexgrid.distance(last_spot)
  end

  def test_xdist_longer_than_ydist
    moves = "ne,ne,ne,se,ne,se,ne,se".split(',')
    last_spot = Hexgrid.final_position(moves)
    assert_equal 8, Hexgrid.distance(last_spot)
  end
  
  def test_day11_part1
    last_spot = Hexgrid::Position.new(664, 91)
    assert_equal 664, Hexgrid.distance(last_spot)
  end

  def test_error_on_bad_input
    moves = "n,n,n,n,flarg".split(',')
    assert_raises ArgumentError do 
      Hexgrid.final_position(moves)
    end
  end

  # Part 2: Max distance away
  def test_max_distance_on_return_to_zero
    assert_equal 2, Hexgrid.max_distance(["ne", "ne", "sw", "sw"])
  end
end
