require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index > @length - 1 || index < 0
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index > @length - 1 || index < 0
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[@length -1] = val
    nil
  end

  # O(1)
  def shift
    raise 'index out of bounds' if length == 0
    shifted = self[0]
    self[0] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)

    i = 0
    until i == @length
      new_store[i] = self[i]
      i += 1
    end
    @store = new_store
    self.start_idx = 0
    @capacity *= 2
  end
end
