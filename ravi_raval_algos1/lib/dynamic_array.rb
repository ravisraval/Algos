require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @capacity = capacity
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= @length
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    pop = self[@length - 1]
    @length -= 1
    pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@length - 1] = val

  end

  # O(n): has to shift over all the elements.
  def shift
    shifted = self[0]
    (@length - 1).times do |i|
      self[i] = self[i + 1]
    end
    @length -= 1
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1

    i = @length - 2

    until i < 0
      self[i + 1] = self[i]
      i -= 1
    end

    self[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2

    new_store = StaticArray.new(@capacity)
    @length.times do |i|
      p i

      new_store[i] = @store[i]
    end
    @store = new_store
  end
end
