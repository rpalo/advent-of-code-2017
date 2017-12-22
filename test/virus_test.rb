# frozen_string_literal: true

require 'test_helper'
require 'virus'

# Test cases for Virus
class TestVirus < Minitest::Test
  def setup
    start_map = <<~HEREDOC
      ..#
      #..
      ...
    HEREDOC
    @v = Virus.new(start_map)
  end

  def test_right_turn_around_end_of_list
    @v.current = Virus::Point.new(11, 10)
    @v.facing = Virus::Point.new(0, -1)
    @v.cycle(1)
    assert_equal Virus::Point.new(-1, 0), @v.facing
  end

  def test_part_2
    @v.cycle(100)
    assert_equal 26, @v.infections
  end

end
