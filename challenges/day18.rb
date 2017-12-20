# frozen_string_literal: true


## I KNOW MY CODE FOR THIS DAY IS YUCKY.  I'LL COME BACK AND FIX IT
## WHEN I'M LESS GRUMPY.  MF jgz 1 3.

require_relative '../lib/duet'

instructions = ARGF.read.chomp
d = Duet.new(instructions)
puts "Number of sends by #1: #{d.count_communications(1)}"

#E
