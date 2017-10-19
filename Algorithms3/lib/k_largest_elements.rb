require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  i=0
  while i < array.length
    heap.push(array[i])
    i+=1
  end
  j = 0
  while j < array.length - k
    heap.extract
    j+=1
  end
  heap.store
end
