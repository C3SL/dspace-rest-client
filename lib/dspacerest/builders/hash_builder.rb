module DSpaceRest
  module Builders
    module HashBuilder

      def self.models2hash(list)
        hash = []
        unless list.nil?
          list.each do |m|
            hash << m.to_h
          end
        end

        hash
      end

    end
  end
end
