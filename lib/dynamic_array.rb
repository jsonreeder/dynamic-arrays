require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 0
    @store = StaticArray.new(@length)
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' if index >= @length
    @store[index] = value
    @length += 1
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length.zero?
    @length -= 1
    @store[length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    # Check capacity, resize if necessary
    if @length == @capacity
      @capacity *= 2
      new_store = StaticArray.new(@capacity)
      @length.times { |idx| new_store[idx] = @store[idx] }
      @store = new_store
    end

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length.zero?
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
