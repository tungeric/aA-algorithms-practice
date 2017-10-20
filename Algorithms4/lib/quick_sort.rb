class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    left_arr = []
    right_arr = []
    pivot = array.shift
    array.each do |el|
      el <= pivot ? left_arr << el : right_arr << el
    end
    sort1(left_arr) + [pivot] + sort1(right_arr)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if length <= 1
    pivot_idx = partition(array, start, length, &prc)
    length_left = pivot_idx - start
    length_right = length - (length_left + 1)
    sort2!(array, start, length_left, &prc)
    sort2!(array, pivot_idx + 1, length_right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot_idx = start
    (start + 1 ... start + length).each do |idx|
      if prc.call(array[idx], array[pivot_idx]) < 0
        array[pivot_idx + 1], array[idx] = array[idx], array[pivot_idx + 1]
        array[pivot_idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[pivot_idx]
        pivot_idx += 1
      end
    end
    pivot_idx
  end
end
