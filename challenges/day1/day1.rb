# Part 1 - Sum all the numbers where the next one matches
def sum_of_matches(nums)
  circular_nums = [nums.last] + nums
  total = 0
  circular_nums.each_with_index do |num, ind|
    total += num.to_i if num == circular_nums[ind + 1]
  end
  total
end

# Part 2 - Sum all the numbers where it matches the one on the other
#           side of the circle
def sum_of_halfway_matches(nums)
  rotated = nums.rotate(nums.length/2)
  matches = nums.zip(rotated)
  matches.reduce(0) do |total, pair|
    total += pair.first.to_i if pair.first == pair.last
  end
end

puts sum_of_halfway_matches(ARGF.read.chomp.chars)
