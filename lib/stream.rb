# frozen_string_literal: true

class Stream
  def initialize(phrase)
    @phrase = phrase
  end

  # Part 1: Score valid groups
  def score
    group_stack = 0
    total_score = 0
    is_garbage = false
    is_skip = false
    @phrase.each_char.with_index do |char, ind|
      if is_skip
        is_skip = false
        next
      end

      if char == '!'
        is_skip = true
        next
      end

      if char == '>'
        is_garbage = false
      elsif char =='<'
        is_garbage = true
      end

      next if is_garbage

      if char == '{'
        group_stack += 1
      elsif char == '}'
        total_score += group_stack
        group_stack -= 1
      end
    end
    total_score
  end

  # Part 2: score uncancelled garbage
  def garbage_score
    total_score = 0
    is_garbage = false
    is_skip = false
    @phrase.each_char.with_index do |char, ind|
      if is_skip
        is_skip = false
        next
      end

      if char == '!'
        is_skip = true
        next
      end

      if char == '>'
        is_garbage = false
      elsif char == '<' && !is_garbage
        is_garbage = true
        next
      end

      if is_garbage
        total_score += 1
        next
      end
    end
    total_score
  end
end
