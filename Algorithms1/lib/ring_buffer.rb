require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @capacity = capacity
    @count = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
     if index >= @count
      raise "index out of bounds"
      return nil
    elsif index < 0
      if index < -(@count)
        raise "index out of bounds" 
        return nil
      end
      return self[@count + index]
    else
      @store[(@start_idx + index) % @capacity]
    end
    
  end

  # O(1)
  def []=(index, val)
    if index >= @count
      (index - @count).times { push(nil) }
    elsif index < 0
      return nil if index < -(@count)
      return self[@count + index] = val
    end

    if index == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    if @count == 0
      raise "index out of bounds"
      return nil
    end
    last_item = @store[(@start_idx + @count - 1) % @capacity]
    @count -= 1
    last_item
  end

  # O(1) ammortized
  def push(val)
    resize! if capacity == @count
    @store[(@start_idx + @count) % @capacity] = val
    @count += 1
    self
  end

  # O(1)
  def shift
    if @count == 0
      raise "index out of bounds"
      return nil
    end
    @count -= 1
    first_item = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    first_item
  end

  # O(1) ammortized
  def unshift(val)
    resize! if capacity == @count
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @count += 1
    self
  end
  
  def length
    @count
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    capacity = @capacity * 2
    new_store = StaticArray.new(capacity)
    
    i = 0
    while i < @store.length
      new_store[i] = @store[(@start_idx + i) % @capacity]
      i+=1
    end
    @store = new_store
    @start_idx = 0
    @capacity = capacity
  end
end
