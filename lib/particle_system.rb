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
end
