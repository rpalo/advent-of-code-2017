# frozen_string_literal: true

require_relative 'tower'

# System to manage/build towers
class TowerSystem
  def initialize(text)
    @towers = {}
    get_towers_from_text(text)
    match_children_and_parents(text)
  end

  def base
    @towers.find { |name, tower| tower.parent.nil? }[0]
  end

  def get_towers_from_text(text)
    text.each_line do |line|
      name = line.split.first
      @towers[name] = Tower.new(name)
    end
  end

  def match_children_and_parents(text)
    children_regex = /-> ([a-z]+(, [a-z]+)*)/
    text.each_line do |line|
      children = children_regex.match(line).to_a[1]
      next if children.nil?
      parent_value = line.split.first
      children.split(", ").each do |child_value|
        @towers[child_value].parent = @towers[parent_value]
        @towers[parent_value].children << @towers[child_value]
      end
    end
  end
end
