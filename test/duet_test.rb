# frozen_string_literal: true

require 'test_helper'
require 'duet'

# Test cases for Duet
class TestDuet < Minitest::Test
  def test_part_1
    instructions = <<~HEREDOC
      set a 1
      add a 2
      mul a 3
      mod a 5
      snd a
      set a 0
      rcv a
      jgz a -1
      set a 1
      jgz a -2
    HEREDOC
    d = Duet.new
    result = d.read_to_recover(instructions)
    assert_equal 4, result
  end

  def test_set
    d = Duet.new
    d.set("a", 1)
    assert_equal 1, d["a"]
  end

  def test_add
    d = Duet.new
    d.set("a", 1)
    d.add("a", 2)
    assert_equal 3, d["a"]
  end

  def test_mul
    d = Duet.new
    d.set("a", 3)
    d.mul("a", 2)
    assert_equal 6, d["a"]
  end

  def test_mod
    d = Duet.new
    d.set("a", 6)
    d.mod("a", 5)
    assert_equal 1, d["a"]
  end

  def test_rcv_and_send
    d = Duet.new
    d.set("a", 2)
    d.snd("a")
    d.set("a", 3)
    assert_equal 2, d.rcv("a")
  end
end
