require 'curb'

module DSpaceRest
  class Item

    attr_accessor :name, :archived, :withdrawn

    attr_reader :id, :handle, :type, :link, :last_modified,
                :parent_collection, :parent_collection_list, :bit_streams,
                :expand, :metadata

    def initialize args
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @last_modified = args['lastModified']
      @parent_collection = DSpaceRest::Collection.new(args['parentCollection']) unless args['parentCollection'].nil?
      @parent_collection_list = build_collections(args['parentCollectionList']) unless args['parentCollectionList'].empty?
      @parent_community_list = build_communities(args['parentCommunityList']) unless args['parentCommunityList'].empty?
      @bit_streams = build_bitstreams(args['bitstreams']) unless args['bitstreams'].empty?
      @archived = args['archived']
      @withdrawn = args['withdrawn']
      @expand = args['expand']
      @metadata = build_metadatas(args['metadata']) unless args['expand'].empty?
    end

    def to_h
      h = Hash.new
      h["id"] = @id
      h["name"] = @name
      h["handle"] = @handle
      h["type"] = @type
      h["link"] = @link
      h["lastModified"] = @last_modified
      h["parentCollection"] = @parent_collection
      h["parentCollectionList"] = @parent_collection_list
      h["parentCommunityList"] = @parent_community_list
      h["bitstreams"] = @bit_streams
      h["archived"] = @archived
      h["withdrawn"] = @withdrawn
      h["expand"] = @expand

      if !@metadata.empty?
        h["metadata"] = metadata2hash @metadata
      end

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

    def build_metadatas(metadatas=[])
      colls = []
      metadatas.each do |c|
        colls << DSpaceRest::Metadata.new(c)
      end
      colls
    end

    def metadata2hash(metadata)
      hash = []
      @metadata.each do |m|
        hash << m.to_h
      end

      hash
    end

    def build_communities(communities=[])
      colls = []
      communities.each do |c|
        colls << DSpaceRest::Community.new(c)
      end
      colls
    end

    def build_collections(collections=[])
      colls = []
      collections.each do |c|
        colls << DSpaceRest::Collection.new(c)
      end
      colls
    end

    def build_bitstreams(bitstreams=[])
      colls = []
      bitstreams.each do |c|
        colls << DSpaceRest::Bitstream.new(c)
      end
      colls
    end

  end
end
