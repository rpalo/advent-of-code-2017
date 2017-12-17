# frozen_string_literal: true

## I know this solution isn't the fastest (constantly resizing the array)
## but it works.  Could be improved.

require_relative '../lib/spinlock'

step_size = 328
lock = Spinlock.new
lock.spin(step_size, 2017)
puts "Item after 2017: #{lock[lock.current + 1]}"

lock  = Spinlock.new
lock.spin(step_size, 50_000_000)
result = lock[1]
puts "Item after 0 after 50,000,000: #{result}"
