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

  def score
    total = 0
    @reps.times do |i|
      target = lowest_bits(@gens.first.next, 16)
      total += 1 if @gens.drop(1).all? do |gen|
        lowest_bits(gen.next, 16) == target
      end
      puts "#{i} reps complete" if (i % 10000).zero?
    end
    total
  end
end
