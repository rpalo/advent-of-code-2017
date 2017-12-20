# frozen_string_literal: true

require_relative '../lib/particle_system'

instructions = ARGF.read.chomp
sys = ParticleSystem.new(instructions)
closest = sys.closest_eventually
p closest
puts "Closest particle after a while is ID# #{closest.id}"
