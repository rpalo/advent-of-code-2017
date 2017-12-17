# frozen_string_literal: true

require 'test_helper'
require 'dance'

# Test cases for Dance
class TestDance < Minitest::Test
  def test_spin_swaps_items_from_rear_to_front
    assert_equal 'cdeab', Dance.spin('abcde', 3)
  end

  def test_exchange_switches_items_at_indices
    assert_equal 'eabdc', Dance.exchange('eabcd', 3, 4)
  end

  def test_partner_switches_items
    assert_equal 'baedc', Dance.partner('eabdc', 'e', 'b')
  end

  def test_can_read_spin_instructions
    assert_equal 'cdeab', Dance.read('s3', 'abcde')
  end

  def test_can_read_exchange_instructions
    assert_equal 'eabdc', Dance.read('x3/4', 'eabcd')
  end

  def test_can_read_partner_instructions
    assert_equal 'baedc', Dance.read('pe/b', 'eabdc')
  end
end
