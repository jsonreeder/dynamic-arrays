require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    physical_index = (index + @start_idx) % @capacity
    @store[physical_index]
  end

  # O(1)
  def []=(index, val)
    physical_index = (index + @start_idx) % @capacity
    @store[physical_index] = val
  end

  # O(1)
  def pop
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[@length - 1] = val
  end

  # O(1)
  # Remove
  def shift
  end

  # O(1) ammortized
  # Add
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
