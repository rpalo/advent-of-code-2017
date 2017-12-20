# frozen_string_literal: true

require_relative '../lib/packet'

packet_map = ARGF.read.chomp
packet = Packet.new
packet.travel(packet_map)
puts "Saw the letters #{packet.history.join}"
