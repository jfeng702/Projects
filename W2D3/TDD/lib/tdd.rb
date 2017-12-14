class Array

  def my_uniq
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    result

  end

  def two_sum
    result = []
    (0...self.length-1).each do |start_idx|
      (start_idx+1 ..self.length-1).each do |end_idx|
        result << [start_idx,end_idx] if self[start_idx] + self[end_idx] == 0
      end
    end
    result
  end
end

def my_transpose(arr)
  result = Array.new(arr.length) {Array.new(arr.length)}
  (0...arr.length).each do |i|
    (0...arr.length).each do |j|
      result[j][i] = arr[i][j]
    end
  end
  result
end
