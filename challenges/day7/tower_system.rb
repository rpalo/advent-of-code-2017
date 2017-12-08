# frozen_string_literal: true

require_relative 'tower'

# System to manage/build towers
class TowerSystem
  def initialize(text)
    @towers = {}
    get_towers_from_text(text)
    match_children_and_parents(text)
  end

  # Part 1: Find base tower
  def base
    _, result = @towers.find { |name, tower| tower.parent.nil? }
    result
  end

  # Part 2: Finds the unbalanced tower and returns the corrected version
  def corrected_tower
    current_tower = base
    current_tower = unbalanced_child(current_tower) until unbalanced_child(current_tower).nil?
    sibling = current_tower.parent.children.find { |child| child != current_tower }
    required_sum = sibling.total_weight
    current_sum = current_tower.total_weight
    adjustment = current_sum - required_sum
    Tower.new(
      current_tower.name,
      current_tower.weight - (adjustment)
    )
  end

  def unbalanced_child(tower)
    weights = tower.children.group_by { |child| child.total_weight }
    weird_weight = weights.find { |weight, children| children.size == 1 }
    return nil unless weird_weight
    _, children_at_weird_weight = weird_weight
    children_at_weird_weight.first
  end

  def get_towers_from_text(text)
    tower_regex = /^([a-z]+) \(([0-9]+)\)/
    text.each_line do |line|
      results = tower_regex.match(line)
      name, weight = results.to_a[1..2]
      @towers[name] = Tower.new(name, weight.to_i)
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

  def get_by_name(name)
    @towers[name]
  end
end
