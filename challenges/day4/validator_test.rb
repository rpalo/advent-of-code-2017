# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'validator'

# Test cases for phassphrase validator
class TestValidator < Minitest::Test
  # Part 1: Count valid passwords
  def test_no_duplicates_is_valid
    assert Validator.valid?("aa bb cc dd ee")
  end

  def test_duplicates_arent_valid
    refute Validator.valid?("aa bb cc dd aa")
  end

  def test_words_counted_as_different_if_different_number_of_letters
    assert Validator.valid?("aa bb cc dd aaa")
  end
end
