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

      def self.build_schemas(schemas=[])
        return schemas unless schemas.is_a? Array
        colls = []
        schemas.each do |c|
          colls << Dspace::Schema.new(c)
        end
        colls
      end

      def self.build_fields(fields=[])
        return fields unless fields.is_a? Array
        colls = []
        fields.each do |c|
          colls << Dspace::MetadataField.new(c)
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

      def self.build_reports(reports=[])
        return reports unless reports.is_a? Array
        colls = []
        reports.each do |c|
          colls << Dspace::Report.new(c)
        end
        colls
      end

      def self.build_item_filters(item_filters=[])
        return item_filters unless item_filters.is_a? Array
        colls = []
        item_filters.each do |c|
          colls << Dspace::ItemFilter.new(c)
        end
        colls
      end

      def self.models2hash(list)
        if list.is_a? Array
          list.map do |m|
            m.to_h
          end
        end
      end

    end
  end
end
