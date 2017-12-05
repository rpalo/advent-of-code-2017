# frozen_string_literal: true

require_relative 'crazymaze'
require_relative 'jumpmaze'

points = ARGF.readlines.map(&:to_i)

# Part 1
maze = JumpMaze.new(points)
puts "Steps to escape:", maze.steps_to_escape

# Part 2
maze = CrazyMaze.new(points)
puts "Steps to escape the crazy one:", maze.steps_to_escape

#     *
