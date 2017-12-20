# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/particle_system'

# Test cases for ParticleSystem
class TestParticleSystem < Minitest::Test
  def test_part_1
    particles = <<~HEREDOC
      p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
      p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
    HEREDOC
    sys = ParticleSystem.new(particles)
    closest = sys.closest_eventually
    p closest
    assert_equal 1, closest.id
  end

  def test_part_2
    particles = <<~HEREDOC
      p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
      p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
      p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
      p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
    HEREDOC
    sys = ParticleSystem.new(particles)
    particles_left = sys.remaining_after_collisions
    assert_equal 1, particles_left.size
  end
end
