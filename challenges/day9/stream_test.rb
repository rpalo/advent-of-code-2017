# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'stream'

class TestStream < Minitest::Test
  def test_single_group
    assert_equal 1, Stream.new('{}').score
  end

  def test_triple_nested_groups
    assert_equal 6, Stream.new('{{{}}}').score
  end

  def test_siblings
    assert_equal 5, Stream.new('{{},{}}').score
  end

  def test_nested_siblings
    assert_equal 16, Stream.new('{{{},{},{{}}}}').score
  end

  def test_group_of_garbage
    assert_equal 1, Stream.new('{<a>,<a>,<a>,<a>}').score
  end

  def test_garbage_siblings
    assert_equal 9, Stream.new('{{<ab>},{<ab>},{<ab>},{<ab>}}').score
  end

  def test_cancelled_exclamation_points
    assert_equal 9, Stream.new('{{<!!>},{<!!>},{<!!>},{<!!>}}').score
  end

  def test_cancelled_angle_brackets
    assert_equal 3, Stream.new('{{<a!>},{<a!>},{<a!>},{<ab>}}').score
  end
end
