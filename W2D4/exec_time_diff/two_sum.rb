
require 'byebug'

def bad_two_sum?(arr, target_sum)

  (0...arr.length-1).each do |idx1|
    (idx1+1...arr.length).each do |idx2|
      return true if arr[idx1] + arr[idx2] == target_sum
    end
  end
  false
end
# O(n^2)

def ok_two_sum?(arr,target_sum)
  sorted = arr.sort
  # byebug
  complements = sorted.map {|el| target_sum - el}
  # complements = [-2, -1, 3, 5]
  # complements = [-14, -13, -9, -7]
  # sorted.bsearch {|x| }
  idx = sorted.index(target_sum/2)
  sorted.delete_at(idx) if arr.include? (target_sum/2)
  sorted.any? {|el| complements.include?(el)}

end

# [0,2,5,7], 4

def two_sum?(arr, target_sum)
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] += 1
  end

  complements = sorted.map {|el| target_sum - el}
  complements.each do |com|
    return true if hash[com] >= 1 && com != target_sum

  end
end
