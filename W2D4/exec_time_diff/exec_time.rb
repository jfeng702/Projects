list1 = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
list2 = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#     my_min(list)

def my_min(arr)
  min = arr[0]
  (0...arr.length).each_with_index do |el1,idx1|
    (0...arr.length).each_with_index do |el2,idx2|

      min = arr[idx1] if (arr[idx1] < arr[idx2] && arr[idx1] < min)
      # next if idx1 == idx2

    end
  end
  min
end

# O(n^2)

def my_min2(arr)
  min = arr.first
  arr.each {|el| min = el if el < min}
  min
end
# O(n)
[[1],[1,2],[3,4]]
 list = [5, 3, -7]

def sub_sum(arr)
  sub_array = []
  (0...arr.length).each do |idx1|
    (idx1...arr.length).each do |idx2|
      sub_array << arr[idx1..idx2]
    end
  end
  sub_arrays_sum = sub_array.map{|sub| sub.reduce(&:+)}
  sub_arrays_sum.max
end

 # O(n^2)

 def sub_sum2(arr)
   # sub_array = []
   largest_sum = 0
   total_sum = 0
   arr.each_with_index do |el, idx|
     total_sum += el
     largest_sum = total_sum if largest_sum < total_sum
     if total_sum < 0
       total_sum = 0
     end
   end

   largest_sum
 end

arr = [-1,-2,3,-10]
 p sub_sum2(arr)
 # time complexity O(n)
 # space complexity 0(1)
 
