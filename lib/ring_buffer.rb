require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 0
  end

  # O(1)
  def [](index)
    check_index(index)
  end

  # O(1)
  def []=(index, val)
    @store[index] = val
  end

  # O(1)
  def pop
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    self[@length] = val
    @length += 1
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(capacity)
    @length.times { |idx| new_store[idx] = @store[idx] }
    @store = new_store
  end
end
