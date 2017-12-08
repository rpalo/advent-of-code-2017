# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'tower'

class TestTower < Minitest::Test
  def test_provided_example
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
    towers = Tower.build_from_string(tower_string)
    assert_equal "tknk", towers[0].base
  end
end
