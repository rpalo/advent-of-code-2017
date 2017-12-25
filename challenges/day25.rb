# frozen_string_literal: true

require_relative '../lib/turing'

blueprint = ARGF.read.chomp
t = Turing.new(blueprint)
puts "Checksum is #{t.checksum}"
