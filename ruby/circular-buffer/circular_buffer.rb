class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(size)
    @buffer = Array.new(size)
    @head = 0
  end

  def read
    if empty?
      raise BufferEmptyException 
    else
      next_item
    end
  end

  def write(item)
    if full?
      raise BufferFullException
    else
      buffer[next_empty_slot] = item
    end
  end

  def write!(item)
    full? ? overwrite_oldest(item) : write(item)
  end

  def clear
    buffer.fill(nil)
  end

  private

  attr_reader :buffer, :head

  def next_empty_slot
    next_empty_slot_to_right || first_empty_slot_from_start
  end

  def next_empty_slot_to_right
    index = buffer[head..-1].index(nil)
    index += head unless index.nil?
  end

  def first_empty_slot_from_start
    buffer[0..head].index(nil)
  end

  def empty?
    buffer[head].nil?
  end

  def full?
    next_empty_slot.nil?
  end

  def next_item
    buffer[head].tap do
      buffer[head] = nil
      increment_head
    end
  end

  def increment_head
    head <= (buffer.length - 2) ? @head += 1 : @head = 0
  end

  def overwrite_oldest(item)
    buffer[head] = item
    increment_head
  end
end
