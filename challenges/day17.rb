# frozen_string_literal: true

require_relative '../lib/spinlock'

step_size = 328
lock = Spinlock.new
lock.spin(step_size, 2017)
puts "Item after 2017: #{lock[lock.current + 1]}"
