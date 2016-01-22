module Dspace
  module Builders
    module HashBuilder

      def obj2hash(list)
        ::Dspace::Builders::ModelBuilder.models2hash list
      end

    end
  end
end