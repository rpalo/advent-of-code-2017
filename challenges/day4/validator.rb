# frozen_string_literal: true

module Validator
  def self.valid?(phrase)
    words = phrase.split
    total = words.size
    unique = words.uniq.size
    (total - unique).zero?
  end
end