class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
  end

  def count
    @store.count
  end

  def extract
    first_el = @store[0]
    @store[0] = store[-1]
    store[-1] = first_el
    last_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    last_el
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    if @store.length > 1
      new_store = BinaryMinHeap.heapify_up(@store, @store.length-1)
    end
    if new_store
      @store = new_store
    end
    @store
  end

  def [](idx)
    @store[idx]
  end

  def []=(idx, val)
    @store[idx] = val
  end

  def self.child_indices(len, parent_index)
    child_idx = []
    if parent_index * 2 + 1 < len
      child_idx << parent_index*2 + 1
      if child_idx[0] + 1 < len
        child_idx << child_idx[0] + 1
      end
    end
    child_idx
  end

  def self.parent_index(child_index)
    parent = (child_index - 1)/2
    if parent < 0
      raise "root has no parent"
    end
    parent
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    swap = false
    until swap
      swap = true
      child_indices = BinaryMinHeap.child_indices(len, parent_idx)
      if child_indices
        swap_idx = child_indices[0]
        if child_indices.length > 1 && prc.call(array[child_indices[0]], array[child_indices[1]]) > 0
          swap_idx = child_indices[1]
        end
      end
      if swap_idx && prc.call(array[swap_idx], array[parent_idx]) <= 0
        array[swap_idx], array[parent_idx] = array[parent_idx], array[swap_idx]
        swap = false
      end
      parent_idx = swap_idx
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return nil if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    else 
      return nil
    end
    if parent_idx != 0
      heapify_up(array, parent_idx, array.length, &prc)
    end
    array
  end

end
