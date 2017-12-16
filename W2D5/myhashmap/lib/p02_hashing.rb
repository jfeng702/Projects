class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.join('').to_i.hash
  end
end

class String
  def hash
    sum = 0
    self.each_char { |ch| sum += ch.ord }
    sum = sum / self[0].ord
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys
    vals = self.values
    key_sum = 0
    val_sum = 0
    keys.each do |el|
      key_sum += el.to_s.ord
    end
    vals.each do |el|
      val_sum += el.ord
    end
    sum = key_sum + val_sum
    sum.hash 
  end
end
