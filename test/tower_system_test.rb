# frozen_string_literal: true

require 'test_helper'
require 'tower_system'

# Test cases for the Tower System
class TestTowerSystem < Minitest::Test
  def setup
    tower_string = <<~HEREDOC
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
    HEREDOC
    @system = TowerSystem.new(tower_string)
  end

  # Part 1: Find the root of the tower
  def test_provided_example
    assert_equal "tknk", @system.base.name
  end

  # Part 2: Find the correct weight for unbalancing tower
  def test_provided_weight_example
    assert_equal 60, @system.corrected_tower.weight
  end

  # Test cases for get_by_name
  def test_get_tower_by_name_returns_tower_if_exists
    assert_equal 'pbga', @system.get_by_name("pbga").name
  end

  def test_get_tower_by_name_returns_nil_if_none_exists
    assert_nil @system.get_by_name("POTATO")
  end

  # Test cases for unbalanced child method
  def test_unbalanced_child_gets_returned_if_exists
    parent = @system.base
    assert_equal @system.get_by_name("ugml"), @system.unbalanced_child(parent)
  end
end
