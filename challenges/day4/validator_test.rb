# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'validator'

# Test cases for phassphrase validator
class TestValidator < Minitest::Test
  # Part 1: Count passwords with no duplicates
  def test_no_duplicates_is_valid
    assert Validator.no_dupes?("aa bb cc dd ee")
  end

  def test_duplicates_arent_valid
    refute Validator.no_dupes?("aa bb cc dd aa")
  end

  def test_words_counted_as_different_if_different_number_of_letters
    assert Validator.no_dupes?("aa bb cc dd aaa")
  end

  # Part 2: Count passwords with anagram word pairs
  def test_no_anagrams_is_valid
    assert Validator.no_anagrams?("abcde fghij")
  end

  def test_anagram_not_valid
    refute Validator.no_anagrams?("abcde xyz ecdab")
  end

  def test_not_an_anagram_unless_all_letters_used
    assert Validator.no_anagrams?("a ab abc abd abf abj")
  end

  def test_another_example_of_not_all_letters_used
    assert Validator.no_anagrams?("iiii oiii ooii oooi oooo")
  end

  def test_another_not_valid_example
    refute Validator.no_anagrams?("oiii ioii iioi iiio")
  end
end
