# frozen_string_literal: true

require_relative 'solo'

# Music making class
class Duet
  attr_reader :solos
  
  def initialize(instructions)
    @solos = [
      Solo.new(0),
      Solo.new(1),
    ]
    @instructions = instructions
  end

  def count_communications(id)
    until @solos.all?(&:waiting)
      # p self
      active = @solos.find { |solo| !solo.waiting }
      result_state = active.read(@instructions)
      next unless result_state.status == :send
      @solos.reject { |solo| solo == active }.each do |solo|
        solo.enqueue(result_state.value)
      end
    end
    @solos[id].sent
  end
end
