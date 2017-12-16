# frozen_string_literal: true

require 'test_helper'
require 'stream'

class TestStream < Minitest::Test

  # Part 1: Score groups
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

  # Part 2: Count garbage characters
  def test_zero_counted
    assert_equal 0, Stream.new('<>').garbage_score
  end

  def test_words_counted
    assert_equal 17, Stream.new('<random characters>').garbage_score
  end

  def test_brackets_in_garbage_counted
    assert_equal 3, Stream.new('<<<<>').garbage_score
  end

  def test_dont_count_cancelled_chars
    assert_equal 2, Stream.new('<{!>}>').garbage_score
  end

  def test_dont_count_cancelled_bangs
    assert_equal 0, Stream.new('<!!>').garbage_score
  end

  def test_dont_count_lots_of_cancelled_bangs
    assert_equal 0, Stream.new('<!!>>').garbage_score
  end

  def test_count_complex_garbage
    assert_equal 10, Stream.new('<{o"i!a,<{i<a>').garbage_score
  end
end
