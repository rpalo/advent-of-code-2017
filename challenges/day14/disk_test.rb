# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'disk'

# Test cases for Disk
class TestDisk < Minitest::Test
  def test_part_1
    skip
    d = Disk.new("flqrgnkx")
    assert_equal 8108, d.used
  end

  def test_part_2
    d = Disk.new("flqrgnkx")
    assert_equal 1242, d.group_count
  end
end
