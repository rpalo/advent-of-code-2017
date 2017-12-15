# frozen_string_literal: true

# Number judge.  Judges how frequently generators agree
class NumberJudge
  def initialize(reps, gens)
    raise ArgumentError, "Need more than 1 to compare" if gens.size < 2
    @gens = gens
    @reps = reps
  end

  def lowest_bits(num, bits)
    num.to_s(2).rjust(16, '0')[-16..-1]
  end

  def score(picky = false)
    total = 0
    @reps.times do |i|
      first_num = picky ? @gens.first.picky_next : @gens.first.next
      target = lowest_bits(first_num, 16)
      total += 1 if @gens.drop(1).all? do |gen|
        comp = picky ? gen.picky_next : gen.next
        lowest_bits(comp, 16) == target
      end
      puts "#{i} reps complete" if (i % 10000).zero?
    end
    total
  end
end
