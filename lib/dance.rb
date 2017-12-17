# frozen_string_literal: true

# Dancing Instruction processing
module Dance
  def self.read(instruction, letters)
    if reg = /s([0-9]+)/.match(instruction)
      spin(letters, reg.to_a[1].to_i)
    elsif reg = /x([0-9]+)\/([0-9]+)/.match(instruction)
      ind1, ind2 = reg.to_a[1..2].map(&:to_i)
      exchange(letters, ind1, ind2)
    elsif reg = /p([a-z])\/([a-z])/.match(instruction)
      item1, item2 = reg.to_a[1..2]
      partner(letters, item1, item2)
    end
  end

  def self.spin(letters, amount)
    letters[-amount..-1] + letters[0...-amount]
  end

  def self.exchange(letters, ind1, ind2)
    result = letters.dup
    result[ind1], result[ind2] = result[ind2], result[ind1]
    result
  end

  def self.partner(letters, item1, item2)
    ind1 = letters.index(item1)
    ind2 = letters.index(item2)
    exchange(letters, ind1, ind2)
  end
end
