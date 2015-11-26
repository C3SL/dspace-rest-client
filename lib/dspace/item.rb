module Dspace
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
      @parent_collection = Dspace::Collection.new(args['parentCollection']) unless args['parentCollection'].nil?
      @parent_collection_list = Dspace::Builders::ModelBuilder.build_collections(args['parentCollectionList'])
      @parent_community_list = Dspace::Builders::ModelBuilder.build_communities(args['parentCommunityList'])
      @bit_streams = Dspace::Builders::ModelBuilder.build_bitstreams(args['bitstreams'])
      @archived = args['archived']
      @withdrawn = args['withdrawn']
      @expand = args['expand']
      @metadata = Dspace::Builders::ModelBuilder.build_metadatas(args['metadata'])
    end

    def to_h
      {
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
    end

    def add_metadata(key, value, language)
      m = {}
      m['key'] = key
      m['value'] = value
      m['language'] = language || ""

      @metadata << Dspace::Metadata.new(m)
      @metadata
    end

    def reset_metadata
      @metadata = []
    end

    private

    def obj2hash(list)
      Dspace::Builders::HashBuilder.models2hash list
    end

  end
end