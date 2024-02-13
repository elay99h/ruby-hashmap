#hash_map

require './node'

class HashMap
  attr_accessor :buckets, :load_factor, :size

  def initialize(capacity = 16, load_factor = 0.75)
    @buckets = Array.new(capacity)
    @load_factor = load_factor
    @size = 0
  end

  def hash_function(key)
    hash_code = 0
    prim_num = 31
    key.each_char { |char| hash_code = hash_code * prim_num + char.ord }
    hash_code % @buckets.size
  end

  def set(key, value)
    index = hash_function(key)

    if @buckets[index].nil?
       @buckets[index] = Node.new(key, value)
    else
        #start iterarating from here
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


end # // set
end # // hash_map

data = HashMap.new
