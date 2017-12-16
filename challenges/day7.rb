# frozen_string_literal: true

require_relative '../lib/tower_system'

build_string = ARGF.read
system = TowerSystem.new(build_string)

# Part 1:
puts "Root tower:", system.base.name

# Part 2:
puts "Corrected weight:", system.corrected_tower.weight

#+
