# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      add_node(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value, tree_node = @root)
    self.class.find!(@root, value)
  end

  def delete(value)
    remove_node = find(value)
    if remove_node.nil?
      return nil
    end
    if remove_node.left
      next_left = maximum(remove_node.left)
      if next_left.left
        next_left.parent.right = next_left.left
      else
        next_left.parent.right = nil
      end
      remove_node.left = next_left.left
      remove_node.right = next_left.right
      remove_node.value = next_left.value
    elsif remove_node.right
      next_right = minimum(remove_node.right)
      if next_right.right
        next_right.parent.left = next_right.right
      else
        next_right.parent.left = nil
      end
      remove_node.left = next_right.left
      remove_node.right = next_right.right
      remove_node.value = next_right.value
    else
      if remove_node == @root
        return @root = nil
      else
        if remove_node.parent.left == remove_node
          remove_node.parent.left = nil
        elsif remove_node.parent.right == remove_node
          remove_node.parent.right = nil
        end
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      tree_node
    else
      maximum(tree_node.right)
    end
  end

  def minimum(tree_node = @root)
    if tree_node.left.nil?
      tree_node
    else
      minimum(tree_node.left)
    end
  end

  def depth(tree_node = @root)
    return -1 unless tree_node
    1 + [depth(tree_node.left),depth(tree_node.right)].max
  end 

  def is_balanced?(tree_node = @root)
    left_side = depth(tree_node.left)
    right_side = depth(tree_node.right)
    (left_side - right_side).abs < 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return nil if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:

  def add_node(node, value)
    if value <= node.value
      if node.left.nil?
        node.left = BSTNode.new(value, node)
      else
        add_node(node.left, value)
      end
    else
      if node.right.nil?
        node.right = BSTNode.new(value, node)
      else
        add_node(node.right,value)
      end
    end
  end

  def self.find!(node, value)
    if node.nil?
      return nil
    elsif value == node.value
      return node
    elsif value < node.value
      find!(node.left, value)
    else
      find!(node.right, value)
    end
  end
end
