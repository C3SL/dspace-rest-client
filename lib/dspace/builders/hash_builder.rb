module Dspace
  module Builders
    module HashBuilder

      def obj2hash(list)
        self.class.models2hash list
      end

      def self.models2hash(list)
        if list.is_a? Array
          hash = []
          list.each do |m|
            hash << m.to_h
          end

          hash
        end
      end

    end
  end
end