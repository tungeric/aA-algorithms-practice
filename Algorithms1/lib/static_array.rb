# This class just dumbs down a regular Array to be statically sized.
class StaticArray

  attr_accessor :length

  def initialize(length)
    @store = Array.new(length)
    @length = length
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless 0 <= index && (@length - 1) >= index
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless 0 <= index && (@length - 1) >= index
    @store[index] = value
  end

  protected
  attr_accessor :store
end
