

class HashMap

    # initialize
    def initialize
        @buckets = Array.new(10) { [] }
        @size = 0
        @load_factor = 0.75
    end

    # calculates a hash code for a given key
    def hash_function(key)
        hash_code = 0
        prim_num = 31
        key.each_char { |char| hash_code = prim_num * hash_code + char.ord }

        hash_code % @buckets.length
    end

    # updates a key-value pair in the hashmap.
    def set(key, value)
        bucket_index = hash_function(key)
        raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

        bucket = @buckets[bucket_index]

        bucket_pair = bucket.find { |pair| pair[0] == key }

        if bucket_pair
        bucket_pair[1] == value
        end

        bucket << [key, value]
    end
end
