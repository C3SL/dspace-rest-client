module Dspace
  class Community

    attr_accessor :name, :logo, :copyright_text,
                  :introductory_text, :short_description, :sidebar_text

    attr_reader :id, :handle, :type, :link, :parent_community,
                :count_items, :sub_communities, :collections, :expand

    def initialize(args={})
      @id = args['id'] || args['uuid']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = Dspace::Bitstream.new(args['logo']) unless args['logo'].nil?
      @parent_community = Dspace::Community.new(args['parentCommunity']) unless args['parentCommunity'].nil?
      @copyright_text = args['copyrightText'] || args['copyright_text']
      @introductory_text = args['introductoryText'] || args['introductory_text']
      @short_description = args['shortDescription'] || args['short_description']
      @sidebar_text = args['sidebarText'] || args['sidebar_text']
      @count_items = args['countItems']

      # subcommunities = All community endpoints
      # community = Hierarchy endpoint
      sub_communities = args['subcommunities'] || args['community']
      @sub_communities = Dspace::Builders::ModelBuilder.build_communities(sub_communities) unless sub_communities.nil?

      # collections = All community/collection endpoints
      # collection = Hierarchy endpoint
      collections = args['collections'] || args['collection']
      @collections = Dspace::Builders::ModelBuilder.build_collections(collections) unless collections.nil?

      @expand = args['expand']
    end

    def to_h
      {
          uuid: @id,
          name: @name,
          handle: @handle,
          type: @type,
          link: @link,
          logo: @logo,
          parentCommunity: @parent_community,
          subcommunities: obj2hash(@sub_communities),
          collections: obj2hash(@collections),
          copyrightText: @copyright_text,
          introductoryText: @introductory_text,
          shortDescription: @short_description,
          sidebarText: @sidebar_text,
          countItems: @count_items,
          expand: @expand
      }
    end

    private

    def obj2hash(list)
      Dspace::Builders::ModelBuilder.models2hash list if list.is_a? Array
    end

  end
end
