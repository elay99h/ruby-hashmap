# hash_map

require './node'

class HashMap
  attr_accessor :buckets, :load_factor, :length, :capacity

  def initialize(capacity = 16, load_factor = 0.75)
    @buckets = Array.new(capacity)
    @load_factor = load_factor
    @capacity = capacity
    @length = 0
  end

  def hash_function(key, capacity = @capacity)
    hash_code = 0
    prim_num = 31
    key.each_char { |char| hash_code = hash_code * prim_num + char.ord }
    hash_code % capacity
  end

  def set(key, value)
    index = hash_function(key)
   raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      @buckets[index] = Node.new(key, value)
    else
      curr_node = @buckets[index]

      while curr_node.key != key && curr_node.next_node
        curr_node = curr_node.next_node
      end

      if curr_node.key == key
        curr_node.value = value
      else
        curr_node.next_node = Node.new(key, value)
      end
    end

    @length += 1

    if load_factor_exceeded?
      grow_buckets
    end

  end

  def get(key)
    index = hash_function(key)
   raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      nil
    else
      curr_node = @buckets[index]

      while curr_node.key != key
        curr_node = curr_node.next_node
      end
      curr_node.value
    end



  end

  def has?(key)
    index = hash_function(key)
   raise IndexError if index.negative? || index >= @buckets.length

    curr_node = @buckets[index]

    if curr_node.nil?
      false
    else

      while curr_node
        return true if curr_node.key == key

        curr_node = curr_node.next_node
      end

      false
    end
  end

  def remove(key)
    index = hash_function(key)
       raise IndexError if index.negative? || index >= @buckets.length

    curr_node = @buckets[index]
    prev_node = nil

    return nil if !has?(key)

    while curr_node && curr_node.key != key
      prev_node = curr_node
      curr_node = curr_node.next_node
    end

    if prev_node.nil?
      @buckets[index] = curr_node.next_node
    else
      prev_node.next_node = curr_node.next_node
    end

    curr_node.value
    @length -= 1
  end

  def length
    @length
  end

  def clear
    @buckets = Array.new(@capacity)
    @length = 0
  end

  def keys
    all_keys = []

    @buckets.each do |bucket|
      curr_node = bucket

      while curr_node
        all_keys << curr_node.key
        curr_node = curr_node.next_node
      end
    end

    all_keys
  end

  def values
    all_values = []

    @buckets.each do |bucket|
      curr_node = bucket

      while curr_node
        all_values << curr_node.value
        curr_node = curr_node.next_node
      end
    end

    all_values
  end

  def entries
    entries = []

    @buckets.each do |bucket|
      curr_node = bucket

      while curr_node
        entries << [bucket.key, bucket.value]
        curr_node = curr_node.next_node
      end
    end
    entries
  end

  def grow_buckets
  new_capacity = @capacity * 2
  new_buckets = Array.new(new_capacity)

  @buckets.each do |bucket|
    curr_node = bucket

    while curr_node

      new_index = hash_function(curr_node.key, new_capacity)

      if new_buckets[new_index].nil?
        new_buckets[new_index] = Node.new(curr_node.key, curr_node.value)
      else
        nb_curr_node = new_buckets[new_index]
        while nb_curr_node.next_node
          nb_curr_node = nb_curr_node.next_node
        end
        nb_curr_node.next_node = Node.new(curr_node.key, curr_node.value)
      end

      curr_node = curr_node.next_node
    end
  end

  @buckets = new_buckets
  @capacity = new_capacity
end

  def load_factor_exceeded?
    (@length.to_f / @capacity) > @load_factor
  end

end


