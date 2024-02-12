

class HashMap

    def initialize
        @buckets = Array.new(16) { [] }
        @size = 0
        @load_factor = 0.75
    end

    def hash_function(key)
        hash_code = 0
        prim_num = 31
        key.each_char { |char| hash_code = prim_num * hash_code + char.ord }

        hash_code
    end


end
