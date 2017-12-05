# frozen_string_literal: true

require_relative 'validator'

phrases = ARGF.readlines
valid_phrases = phrases.select { |phrase| Validator.valid?(phrase) }
puts "# of valid phrases:", valid_phrases.size

#+.
