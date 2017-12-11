# frozen_string_literal: true

module Hexgrid

  Position = Struct.new(:x, :y)

  def self.final_position(steps)
    pos = Position.new(0, 0)
    steps.each.with_index do |step, ind|
      case step
      when "nw"
        pos.y += 0.5
        pos.x -= 1
      when "n"
        pos.y += 1
      when "ne"
        pos.y += 0.5
        pos.x += 1
      when "sw"
        pos.y -= 0.5
        pos.x -= 1
      when "s"
        pos.y -= 1
      when "se"
        pos.y -= 0.5
        pos.x += 1
      else
        raise ArgumentError, "Can't process move #{step} at #{ind}"
      end
      # puts "Move: #{step}, Pos: #{pos}"
    end
    pos
  end

  def self.distance(pos)
    # if pos.y.abs >= pos.x.abs / 2
    #   (
    #     pos.x.abs -       # add x steps required
    #     pos.x.abs / 2 +   # remove .5 x steps
    #     pos.y.abs         # because they're counted in Y
    #   ).floor
    # else
    #   pos.x.abs
    # end
    (pos.x.abs + [pos.y.abs - pos.x.abs / 2, 0].max).floor
  end
end