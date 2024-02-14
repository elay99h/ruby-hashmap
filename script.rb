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
end

def get(key)
  index = hash_function(key)

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




end

data = HashMap.new
data.set("Elay", "Web developer")
data.set("Adam", "Web developer")

p data.has?("Lisa")

