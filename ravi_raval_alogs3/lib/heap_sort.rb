require_relative "heap"

class Array
  def heap_sort!
    1.upto(self.length - 1) do |i|
      child = i
      while child > 0
        parent = (child - 1) / 2
        if self[parent] < self[child]
          self[parent], self[child] = self[child], self[parent]
          child = parent
        else
          break
        end
      end
    end

    i = self.length - 1
    while i > 0
      self[0], self[i] = self[i], self[0]
        i -= 1
        parent = 0
        while parent * 2 + 1 <= i
          child = parent * 2 + 1
          if child < i && self[child] < self[child + 1]
            child += 1
          end
          if self[parent] < self[child]
            self[parent], self[child] = self[child], self[parent]
            parent = child
          else
            break
          end
        end
      end
  end
end
