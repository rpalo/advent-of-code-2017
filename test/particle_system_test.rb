# frozen_string_literal: true

require 'test_helper'
require 'particle_system'

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
end
