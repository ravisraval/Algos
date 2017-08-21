require_relative 'bst_practical'

def kth_largest(tree_node, k)
  arr = in_order_traversal(tree_node)
  arr[arr.length - k]
end

def in_order_traversal(tree_node)
  return [] unless tree_node

  arr = []
  arr.concat(in_order_traversal(tree_node.left)) if tree_node.left
  arr << tree_node
  arr.concat(in_order_traversal(tree_node.right)) if tree_node.right

  arr
end
