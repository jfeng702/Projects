require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end
    unless self[key.hash].include?(key)
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
    end
  end

  private

  def [](num)
    index = num % num_buckets
    @store[index]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      unless bucket.empty?
        bucket.each do |el|
          arr[el % (num_buckets * 2)] << el
        end
      end
    end
    @store =  arr
  end
end
