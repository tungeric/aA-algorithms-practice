require_relative "heap"

class Array
  def heap_sort!
    curr_index = 0
    while curr_index < (self.length - 1) do
      BinaryMinHeap.heapify_up(self, curr_index, curr_index + 1)
      curr_index += 1
      puts curr_index
    end
    while curr_index > 0 do
      self[curr_index], self[0] = self[0], self[curr_index]
      BinaryMinHeap.heapify_down(self, 0, curr_index)
      curr_index -= 1
      puts curr_index
    end
    return self.reverse!
  end
end
