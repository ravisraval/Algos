class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |el, idx|
      res += el.hash*idx.hash
    end
    res
  end
end

class String
  def hash
    res = 0
    self.chars.each_with_index do |ch, idx|
      res += (ch.ord + idx).hash
    end
    res
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    res = 0
    self.each do |k, v|
      res += k.hash + v.hash
    end
    res
  end
end
