# frozen_string_literal: true

require_relative 'particle'

# System of x, y, z particles that respond to kinematics
class ParticleSystem
  def initialize(instructions)
    @particles = []
    instructions.each_line.with_index do |instruction, ind|
      @particles << Particle.from_s(ind, instruction)
    end
  end

  def closest_eventually
    @particles.sort_by do |p|
      p.final_position(1_000_000_000)
       .manhattan_distance
    end.first
  end

  def remaining_after_collisions
    remaining = @particles.dup
    1000.times do
      remaining.each(&:update)
      histogram = remaining
                  .group_by(&:position)
      remaining = histogram.reduce([]) do |running, group|
        _position, particles = group
        particles.size == 1 ? running + particles : running
      end
      break if remaining.size == 1
    end
    remaining
  end
end
