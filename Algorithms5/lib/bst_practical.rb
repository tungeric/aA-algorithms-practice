
def kth_largest(tree_node, k)
  array = in_order_traversal(tree_node, [])
  array[array.length - k]
end

def in_order_traversal(tree_node = @root, arr = [])
    return nil if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr << tree_node
    in_order_traversal(tree_node.right, arr)
    arr
  end