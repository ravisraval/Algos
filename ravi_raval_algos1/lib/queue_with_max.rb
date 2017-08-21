# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @max = []
    @store = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    if @max.empty? || @max.last < val
      @max = [val]
    else
      @max.push(val)
    end
  end

  def dequeue
    if @max[0] == @store.shift
      @max.shift
    end

  end

  def max
    @max.first
  end

  def length
    @store.length
  end

end
