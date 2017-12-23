# frozen_string_literal: true

require 'prime'

# Simpler variant on the Duet processor
class Coprocessor
  attr_reader :calls
  attr_accessor :registers

  def initialize
    @registers = Hash.new(0)
    @calls = Hash.new(0)
    @current = 0
  end

  def process(instructions)
    @current = 0
    lines = instructions.lines
    while (0...lines.size).cover?(@current)
      command, arg1, arg2 = lines[@current].split
      result = send(command, arg1, arg2)
      @current += 1 if result
    end
  end

  def optimize_for_h
    b = (81 * 100) + 100_000
    c = b + 17_000
    loop do
      @registers["h"] += 1 unless Prime.prime?(b)
      break if b == c
      b += 17
    end
  end

  def reset
    @registers = Hash.new(0)
    @calls = Hash.new(0)
    @current = 0
  end

  def set(reg, val_or_reg)
    @calls[:set] += 1
    val = get_val(val_or_reg)
    @registers[reg] = val
    true
  end

  def sub(reg, val_or_reg)
    @calls[:sub] += 1
    val = get_val(val_or_reg)
    @registers[reg] -= val
    true
  end

  def mul(reg, val_or_reg)
    @calls[:mul] += 1
    val = get_val(val_or_reg)
    @registers[reg] *= val
    true
  end

  def jnz(val_or_reg, jump_size)
    @calls[:jnz] += 1
    test_val = get_val(val_or_reg)
    if test_val.zero?
      true
    else
      @current += jump_size.to_i
      false
    end
  end

  def get_val(val_or_reg)
    if /[a-z]+/.match?(val_or_reg)
      @registers[val_or_reg]
    else
      val_or_reg.to_i
    end
  end
end
