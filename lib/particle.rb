# frozen_string_literal: true

# x, y, z particle that respond to kinematics
class Particle
  attr_reader :id, :position

  Vector = Struct.new(:x, :y, :z) do
    def +(other)
      Vector.new(x + other.x, y + other.y, z + other.z)
    end

    # Aligned (positive/negative x, y, z match)
    def |(other)
      (x * other.x) >= 0 &&
      (y * other.y) >= 0 &&
      (z * other.y) >= 0
    end

    def *(num)
      Vector.new(x * num, y * num, z * num)
    end

    def manhattan_distance
      x.abs + y.abs + z.abs
    end
  end

  def self.from_s(id, phrase)
    particle_desc = /p=<([ ,\-0-9]+)>, v=<([ ,\-0-9]+)>, a=<([ ,\-0-9]+)>/
    result = particle_desc.match(phrase).to_a
    raise ArgumentError, "#{phrase} does not match particle" unless result.size == 4
    p, v, a = result[1..3].map do |group|
      x, y, z = group.split(",").map(&:to_i)
      Vector.new(x, y, z)
    end
    Particle.new(id, p, v, a)
  end
    
  def initialize(id, pos, vel, accel)
    @id = id
    @position = pos
    @velocity = vel
    @acceleration = accel
  end

  def update
    @velocity += @acceleration
    @position += @velocity
  end

  def final_position(ticks)
    @position + @velocity * ticks + @acceleration * ticks**2
  end
end
