module Dspace
  module Builders
    module ModelBuilder

      def self.build_communities(communities=[])
        return communities if communities.nil?
        colls = []
        communities.each do |c|
          colls << Dspace::Community.new(c)
        end
        colls
      end

      def self.build_collections(collections=[])
        return collections if collections.nil?
        colls = []
        collections.each do |c|
          colls << Dspace::Collection.new(c)
        end
        colls
      end

      def self.build_items(items=[])
        return items if items.nil?
        colls = []
        items.each do |c|
          colls << Dspace::Item.new(c)
        end
        colls
      end

      def self.build_bitstreams(bitstreams=[])
        return bitstreams if bitstreams.nil?
        colls = []
        bitstreams.each do |c|
          colls << Dspace::Bitstream.new(c)
        end
        colls
      end

      def self.build_metadatas(metadatas=[])
        return metadatas if metadatas.nil?
        colls = []
        metadatas.each do |c|
          colls << Dspace::Metadata.new(c)
        end
        colls
      end

      def self.build_policies(policies=[])
        return policies if policies.nil?
        colls = []
        policies.each do |c|
          colls << Dspace::Policy.new(c)
        end
        colls
      end

    end
  end
end
