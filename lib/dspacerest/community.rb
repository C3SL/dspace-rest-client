module DSpaceRest
  class Community

    attr_accessor :name, :logo, :copyright_text,
                  :introductory_text, :short_description, :sidebar_text

    attr_reader :id, :handle, :type, :link, :parent_community,
                :count_items, :sub_communities, :collections, :expand

    def initialize(args={})
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @parent_community = DSpaceRest::Community.new(args['parentCommunity']) unless args['parentCommunity'].nil?
      @copyright_text = args['copyrightText']
      @introductory_text = args['introductoryText']
      @short_description = args['shortDescription']
      @sidebar_text = args['sidebarText']
      @count_items = args['countItems']
      @sub_communities = build_communities(args['subcommunities']) unless args['subcommunities'].empty?
      @collections = build_collections(args['collections']) unless args['collections'].empty?
      @expand = args['expand']
    end

    def to_h
      h = {
          id: @id,
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

      h
    end

    private

    def obj2hash(list)
      hash = []
      list.each do |m|
        hash << m.to_h
      end

      hash
    end

    def build_collections(collections=[])
      colls = []
      collections.each do |c|
        colls << DSpaceRest::Collection.new(c)
      end
      colls
    end

    def build_communities(communities=[])
      colls = []
      communities.each do |c|
        colls << DSpaceRest::Community.new(c)
      end
      colls
    end

  end
end
