def sum_of_matches(nums)
  circular_nums = [nums.last] + nums
  count = 0
  circular_nums.each_with_index do |num, ind|
    count += num.to_i if num == circular_nums[ind + 1]
  end
  count
end

def sum_of_halfway_matches(nums)
  total = 0
  nums.each_with_index do |num, ind|
    halfway_around = (nums.length/2 + ind) % (nums.length - 1)
    total += num.to_i if num == nums[halfway_around]
  end
  total
end

puts sum_of_halfway_matches(ARGF.read.chars)
