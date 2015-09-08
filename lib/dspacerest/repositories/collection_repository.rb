module DSpaceRest
  module Repositories
    class CollectionRepository < AbstractRepository
      # Collections in DSpace are containers of Items

      # √ GET /communities/{communityId}/collections - Returns array of collections of community.
      # √ GET /collections - Return all collections of DSpace in array.
      # √ GET /collections/{collectionId} - Return collection with id.
      # √ GET /collections/{collectionId}/items - Return all items of collection.
      # √ POST /communities/{communityId}/collections - Create new collections in community. You must post Collection.
      # √ POST /collections/{collectionId}/items - Create posted item in collection. You must post an Item
      # POST /collections/find-collection - Find collection by passed name.
      # PUT /collections/{collectionId} - Update collection. You must put Collection.
      # DELETE /collections/{collectionId} - Delete collection from DSpace.
      # DELETE /collections/{collectionId}/items/{itemId} - Delete item in collection.
      # DELETE /communities/{communityId}/collections/{collectionId} - Delete collection in community.

      def get_collection_items(collection, limit = nil, offset = nil)
        limit_uri = build_parameter_uri('limit',limit)
        offset_uri = build_parameter_uri('offset',offset)
        response = rest_client["/collections/#{collection.id}/items&#{limit_uri}&#{offset_uri}"].get
        items = []
        JSON.parse(response).each do |item|
          items << DSpaceRest::Item.new(item)
        end
        items
      end

      def get_collection_by_id(id, expand = nil)
        expand_uri = build_expand_uri(expand)
        response = rest_client["/collections/#{id}?#{expand_uri}"].get
        DSpaceRest::Collection.new(JSON.parse(response))
      end

      def get_all_collections(expand = nil, limit = nil, offset = nil)
        expand_uri = build_expand_uri(expand)
        limit_uri = build_parameter_uri('limit',limit)
        offset_uri = build_parameter_uri('offset',offset)
        response = rest_client["/collections?#{expand_uri}&#{limit_uri}&#{offset_uri}"].get
        collections = []
        JSON.parse(response).each do |coll|
          collections << DSpaceRest::Collection.new(coll)
        end
        collections
      end

      def get_collections_of(community, expand = nil, limit = nil, offset = nil)
        expand_uri = build_expand_uri(expand)
        limit_uri = build_parameter_uri('limit',limit)
        offset_uri = build_parameter_uri('offset',offset)
        response = rest_client["/communities/#{community.id}/collections?#{expand_uri}&#{limit_uri}&#{offset_uri}"].get
        collections = []
        JSON.parse(response).each do |coll|
          collections << DSpaceRest::Collection.new(coll)
        end
        collections
      end

      def create_collection_for(community, collection)
        form = JSON.generate(collection.to_h)
        response = rest_client["/communities/#{community.id}/collections"].post form
        DSpaceRest::Collection.new(JSON.parse(response))
      end

      def create_item_for(collection, item)
        form = JSON.generate({"metadata" => item.to_h[:metadata]})
        response = rest_client["/collections/#{collection.id}/items"].post form
        DSpaceRest::Item.new(JSON.parse(response))
      end

      private

      def expandable_properties
        ["parentCommunityList","parentCommunity","items","license","logo","all"]
      end

      def query_parameters
        ["limit","offset"]
      end

    end
  end
end
