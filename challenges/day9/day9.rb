# frozen_string_literal: true

## I'm not super happy with this solution.  If anybody
## can provide a better alternative, I want to know about it.

require_relative 'stream'

phrase = ARGF.read.chomp
stream = Stream.new(phrase)
puts "Total score", stream.score
puts "Garbage score", stream.garbage_score

#+.
