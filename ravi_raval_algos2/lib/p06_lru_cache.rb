require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      current_node = @map[key]
      update_node!(current_node)
      current_node.val
    else
      new_val = calc!(key)
      @store.append(key, new_val)
      @map[key] = @store.last

      eject! if count > @max
      new_val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    @store.remove(node.key)
    @store.append(node.key, node.val)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    key_to_eject = @store.first.key
    @store.remove(key_to_eject)
    @map.delete(key_to_eject)
  end
end
