module DSpaceRest
  module Repositories
    class ItemRepository < AbstractRepository
      # Items in DSpace represent a "work" and combine metadata and files, known as Bitstreams

      # √ GET /items - Return list of items.
      # √ GET /items/{item id} - Return item.
      # √ GET /items/{item id}/metadata - Return item metadata.
      # √ GET /items/{item id}/bitstreams - Return item bitstreams.
      # POST /items/find-by-metadata-field - Find items by metadata entry. You must post a MetadataEntry.  DS-2501 - wrong SQL in REST /items/find-by-metadata-field CLOSED
      # √ POST /items/{item id}/metadata - Add metadata to item. You must post an array of MetadataEntry
      # √ POST /items/{item id}/bitstreams - Add bitstream to item. You must post a Bitstream
      # √ PUT /items/{item id}/metadata - Update metadata in item. You must put a MetadataEntry
      # √ DELETE /items/{item id} - Delete item.
      # DELETE /items/{item id}/metadata - Clear item metadata.
      # DELETE /items/{item id}/bitstreams/{bitstream id} - Delete item bitstream.


      def get_all_items(params)
        query_string = build_query_string(params)
        puts query_string
        response = rest_client["/items?#{query_string}"].get
        items = []
        JSON.parse(response).each do |item|
          items << DSpaceRest::Item.new(item)
        end
        items
      end

      def get_item_by_id(id, params)
        query_string = build_query_string(params)
        response = rest_client["/items/#{id}?#{query_string}"].get
        DSpaceRest::Item.new(JSON.parse(response))
      end

      def get_metadata_of(item)
        response = rest_client["/items/#{item.id}/metadata"].get
        metadata = []
        JSON.parse(response).each do |m|
          metadata << DSpaceRest::Metadata.new(m)
        end
        metadata
      end

      def get_bitstreams_of(item, params)
        query_string = build_query_string(params)
        response = rest_client["/items/#{item.id}/bitstreams?#{query_string}"].get
        bitstreams = []
        JSON.parse(response).each do |bits|
          bitstreams << DSpaceRest::Bitstream.new(bits)
        end
        bitstreams
      end


      def create_metadata_for(item)
        form = JSON.generate(self.to_h["metadata"])
        response = rest_client["/items/#{item.id}/metadata"].put form
      end

      def create_bitstream_for(item, file, upload_strategy)
        response = upload_strategy.upload("/items/#{item.id}/bitstreams", file)
        DSpaceRest::Bitstream.new(JSON.parse(response))
      end

      def delete(item)
        response = rest_client["/items/#{item.id}"].delete
      end

      private

      def expandable_properties
        ["metadata","parentCollection","parentCollectionList","parentCommunityList","bitstreams","all"]
      end

      def query_parameters
        ["limit","offset"]
      end

    end
  end
end
