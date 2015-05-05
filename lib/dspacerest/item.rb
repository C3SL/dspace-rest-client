require 'curb'

module DSpaceRest
  class Item

    attr_accessor :name, :archived, :withdrawn

    attr_reader :id, :handle, :type, :link, :last_modified, :parent_collection,
                :parent_collection_list, :parent_community_list, :bit_streams,
                :expand, :metadata

    def initialize args
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @last_modified = args['lastModified']
      @parent_collection = DSpaceRest::Collection.new(args['parentCollection']) unless args['parentCollection'].nil?
      @parent_collection_list = DSpaceRest::Builders::ModelBuilder.build_collections(args['parentCollectionList'])
      @parent_community_list = DSpaceRest::Builders::ModelBuilder.build_communities(args['parentCommunityList'])
      @bit_streams = DSpaceRest::Builders::ModelBuilder.build_bitstreams(args['bitstreams'])
      @archived = args['archived']
      @withdrawn = args['withdrawn']
      @expand = args['expand']
      @metadata = DSpaceRest::Builders::ModelBuilder.build_metadatas(args['metadata'])
    end

    def to_h
      h = {
          id: @id,
          name: @name,
          handle: @handle,
          type: @type,
          link: @link,
          lastModified: @last_modified,
          parentCollection: @parent_collection.to_h,
          parentCollectionList: obj2hash(@parent_collection_list),
          parentCommunityList: obj2hash(@parent_community_list),
          bitstreams: obj2hash(@bit_streams),
          archived: @archived,
          withdrawn: @withdrawn,
          expand: @expand,
          metadata: obj2hash(@metadata)
      }

      h
    end

    def add_metadata(key, value, language)
      m = {}
      m['key'] = key
      m['value'] = value
      m['language'] = language || ""

      @metadata << DSpaceRest::Metadata.new(m)
      @metadata
    end

    def reset_metadata
      @metadata = []
    end

    private

    def obj2hash(list)
      DSpaceRest::Builders::HashBuilder.models2hash list
    end

  end
end