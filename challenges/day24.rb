# frozen_string_literal: true

require_relative '../lib/bridge'

connector_text = ARGF.read.chomp
b = Bridge.new(connector_text)
puts "Strongest bridge is #{b.strongest_score}"
