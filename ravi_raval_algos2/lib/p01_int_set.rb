class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true

  end

  def remove(num)
    is_valid?(num)
    @store[num] = false

  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless num <= @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % (num_buckets * 2)].push(num)
      end
    end
    @store = new_store
  end

end
