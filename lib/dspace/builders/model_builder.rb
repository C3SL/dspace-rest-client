module DSpaceRest
  module Builders
    module ModelBuilder

      def self.build_communities(communities=[])
        return communities if communities.nil?
        colls = []
        communities.each do |c|
          colls << DSpaceRest::Community.new(c)
        end
        colls
      end

      def self.build_collections(collections=[])
        return collections if collections.nil?
        colls = []
        collections.each do |c|
          colls << DSpaceRest::Collection.new(c)
        end
        colls
      end

      def self.build_items(items=[])
        return items if items.nil?
        colls = []
        items.each do |c|
          colls << DSpaceRest::Item.new(c)
        end
        colls
      end

      def self.build_bitstreams(bitstreams=[])
        return bitstreams if bitstreams.nil?
        colls = []
        bitstreams.each do |c|
          colls << DSpaceRest::Bitstream.new(c)
        end
        colls
      end

      def self.build_metadatas(metadatas=[])
        return metadatas if metadatas.nil?
        colls = []
        metadatas.each do |c|
          colls << DSpaceRest::Metadata.new(c)
        end
        colls
      end

      def self.build_policies(policies=[])
        return policies if policies.nil?
        colls = []
        policies.each do |c|
          colls << DSpaceRest::Policy.new(c)
        end
        colls
      end

    end
  end
end
