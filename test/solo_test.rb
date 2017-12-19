# frozen_string_literal: true

require 'test_helper'
require 'solo'

# Test cases for Duet
class TestSolo < Minitest::Test
  def setup
    @s = Solo.new(0)
  end

  def test_read_1
    instructions = <<~HEREDOC
      set a 1
      add a 2
      mul a a
      mod a 5
      snd a
      set a 0
      rcv a
      jgz a -1
      set a 1
      jgz a -2
    HEREDOC
    assert_equal Solo::State.new(4, :send), @s.read(instructions)
    assert_equal Solo::State.new(nil, :receive), @s.read(instructions)
    @s.enqueue(0)
    @s.read(instructions)
    assert_equal 1, @s["a"]
    @s.read(instructions)
    assert @s.waiting
    assert_equal 6, @s.current
  end

  def test_set
    @s.set("a", 1)
    assert_equal 1, @s["a"]
  end

  def test_add
    @s.set("a", 1)
    @s.add("a", 2)
    assert_equal 3, @s["a"]
  end

  def test_mul
    @s.set("a", 3)
    @s.mul("a", 4)
    assert_equal 12, @s["a"]
  end

  def test_tracks_snds
    @s.snd("a")
    assert_equal 1, @s.sent
  end

  def test_rcv_waits_if_nothing_in_queue
    @s.rcv("a")
    assert @s.waiting
  end

  def test_enqueue_adds_to_queue
    @s.enqueue(4)
    assert_includes @s.queue, 4
  end

  def test_rcv_accepts_and_doesnt_wait_if_in_queue
    @s.enqueue(4)
    @s.rcv("b")
    assert_equal 4, @s["b"]
    refute @s.waiting
  end

  def test_jump_moves_when_positive_reg
    @s.set("a", 5)
    @s.jgz("a", 3)
    assert_equal 3, @s.current
  end

  def test_jump_does_nothing_when_negative_reg
    @s.set("a", -5)
    @s.jgz("a", 3)
    assert_equal 0, @s.current
  end
end
