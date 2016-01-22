module Dspace
  module Builders
    module ModelBuilder

      def self.build_communities(communities=[])
        return communities unless communities.is_a? Array
        colls = []
        communities.each do |c|
          colls << Dspace::Community.new(c)
        end
        colls
      end

      def self.build_collections(collections=[])
        return collections unless collections.is_a? Array
        colls = []
        collections.each do |c|
          colls << Dspace::Collection.new(c)
        end
        colls
      end

      def self.build_items(items=[])
        return items unless items.is_a? Array
        colls = []
        items.each do |c|
          colls << Dspace::Item.new(c)
        end
        colls
      end

      def self.build_bitstreams(bitstreams=[])
        return bitstreams unless bitstreams.is_a? Array
        colls = []
        bitstreams.each do |c|
          colls << Dspace::Bitstream.new(c)
        end
        colls
      end

      def self.build_metadatas(metadatas=[])
        return metadatas unless metadatas.is_a? Array
        colls = []
        metadatas.each do |c|
          colls << Dspace::Metadata.new(c)
        end
        colls
      end

      def self.build_policies(policies=[])
        return policies unless policies.is_a? Array
        colls = []
        policies.each do |c|
          colls << Dspace::Policy.new(c)
        end
        colls
      end

    end
  end
end
