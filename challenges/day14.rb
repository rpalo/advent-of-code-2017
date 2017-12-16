# frozen_string_literal: true

require_relative '../lib/disk'

key = "hxtvlmkl"
d = Disk.new(key)
puts "Used space: #{d.used}"
puts "# of groups: #{d.group_count}"

#+
