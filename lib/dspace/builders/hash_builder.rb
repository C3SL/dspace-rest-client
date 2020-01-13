module Dspace
  module Builders
    module HashBuilder

      def obj2hash(list)
        ::Dspace::Builders::ModelBuilder.models2hash list if list.is_a? Array
      end

    end
  end
end
