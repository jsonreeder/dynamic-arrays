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
    raise 'index out of bounds' if @length.zero?
    popped_value = self[@length - 1]
    @length -= 1
    popped_value
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
    raise 'index out of bounds' if @length.zero?
    shifted_value = self[0]
    @length -= 1
    @start_idx += 1
    shifted_value
  end

  # O(1) ammortized
  # Add
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    self[-1] = val
    @start_idx -= 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    # debugger
    @start_idx += @capacity
    @capacity *= 2
    new_store = StaticArray.new(capacity)
    @length.times { |idx| new_store[idx] = @store[idx] }
    @store = new_store
    # debugger
  end
end
