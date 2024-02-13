

  require './linked_lists'


  class HashMap

    attr_accessor :buckets, :load_factor

      def initialize
        self.buckets = Array.new(16) { [] }
        self.load_factor = 0.75
      end

      def hash_function(key)
          hash_code = 0
          prim_num = 31
          key.each_char { |char| hash_code = hash_code * prim_num + char.ord}
          hash_code % buckets.size
      end



  end

