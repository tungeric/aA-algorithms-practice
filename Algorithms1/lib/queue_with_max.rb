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
    @store = RingBuffer.new
    @sorted_store = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    if @sorted_store.length > 0
      if val >= @sorted_store[-1]
        @sorted_store.push(val)
      else
        @sorted_store.unshift(val)
      end
    else
      @sorted_store.push(val)
    end
  end

  def dequeue
    first_item = @store.shift
    if first_item == @sorted_store[-1]
      @sorted_store.pop
    else
      new_sorted_store = RingBuffer.new
      i = 0
      while i < @sorted_store.length
        el = @sorted_store[i]
        if el != first_item
          new_sorted_store.push(el)
        end
        i+=1
      end
      @sorted_store = new_sorted_store
    end
    @sorted_store
  end

  def max
    @sorted_store[-1]
  end

  def length
    @store.length
  end

end
