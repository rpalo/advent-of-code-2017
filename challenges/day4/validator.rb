# frozen_string_literal: true

# Validates system passphrases
module Validator
  def self.no_dupes?(phrase)
    words = phrase.split
    total = words.size
    unique = words.uniq.size
    (total - unique).zero?
  end

  def self.no_anagrams?(phrase)
    words = phrase.split
    sorted = words.map { |word| word.chars.sort.join }.join(" ")
    no_dupes?(sorted)
  end

  def self.valid?(phrase)
    no_anagrams?(phrase)
  end
end
