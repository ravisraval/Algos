class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |x, y| x <=> y }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    root = @store[0]
    if count == 1
      @store.pop
    else

      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, &prc)
    end
    root


  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(store, self.count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    res = []
    double_index = parent_index * 2
    res << double_index + 1 if (double_index + 1) < len
    res << double_index + 2 if (double_index + 2) < len

    return nil if res.empty?
    res
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end


  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    number = array[parent_idx]
    children_idx = BinaryMinHeap.child_indices(len, parent_idx)
    if children_idx.nil?
      return array
    elsif children_idx.length == 2
      children = [array[children_idx[0]], array[children_idx[1]]]
    elsif children_idx.length == 1
      children = [array[children_idx[0]]]
    end


    if prc.call(array[parent_idx], children.min) <= 1
      if children.length == 1
        replacement = children[0]
      else
        replacement = prc.call(children[0], children[1]) == -1 ? children[0] : children[1]
      end

      new_idx = array.index(replacement)
      array[parent_idx] = replacement
      array[new_idx] = number
      parent_idx = new_idx
      BinaryMinHeap.heapify_down(array, parent_idx, len, &prc)
    else
      array
    end

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    return array if prc.call(array[child_idx], array[parent_idx]) >= 0

    parent = array[parent_idx]
    child = array[child_idx]
    array[child_idx] = parent
    array[parent_idx] = child
    BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)


  end
end
