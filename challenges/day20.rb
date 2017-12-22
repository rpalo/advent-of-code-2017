# frozen_string_literal: true

require_relative '../lib/particle_system'

instructions = ARGF.read.chomp
sys = ParticleSystem.new(instructions)
closest = sys.closest_eventually
puts "Closest particle after a while is ID# #{closest.id}"
remaining = sys.remaining_after_collisions
puts "# of particles after collision check: #{remaining.size}"

#R
