# frozen_string_literal: true

require_relative 'tower_system'

build_string = ARGF.read
system = TowerSystem.new(build_string)
puts "Root tower:", system.base
