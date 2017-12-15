# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'disk'

# Test cases for Disk
class TestDisk < Minitest::Test
  def test_part_1
    d = Disk.new("flqrgnkx")
    assert_equal 8108, d.used
  end
end
