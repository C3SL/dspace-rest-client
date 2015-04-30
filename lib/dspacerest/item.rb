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
      @parent_collection_list = build_collections(args['parentCollectionList']) unless args['parentCollectionList'].nil?
      @parent_community_list = build_communities(args['parentCommunityList']) unless args['parentCommunityList'].nil?
      @bit_streams = build_bitstreams(args['bitstreams']) unless args['bitstreams'].nil?
      @archived = args['archived']
      @withdrawn = args['withdrawn']
      @expand = args['expand']
      @metadata = build_metadatas(args['metadata']) unless args['expand'].nil?
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

    def build_metadatas(metadatas=[])
      return metadatas if metadatas.nil?
      colls = []
      metadatas.each do |c|
        colls << DSpaceRest::Metadata.new(c)
      end
      colls
    end

    def build_communities(communities=[])
      return communities if communities.nil?
      colls = []
      communities.each do |c|
        colls << DSpaceRest::Community.new(c)
      end
      colls
    end

    def build_collections(collections=[])
      return collections if collections.nil?
      colls = []
      collections.each do |c|
        colls << DSpaceRest::Collection.new(c)
      end
      colls
    end

    def build_bitstreams(bitstreams=[])
      return bitstreams if bitstreams.nil?
      colls = []
      bitstreams.each do |c|
        colls << DSpaceRest::Bitstream.new(c)
      end
      colls
    end

  end
end
