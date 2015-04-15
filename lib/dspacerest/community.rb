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
      @parent_community = args['parentCommunity']
      @copyright_text = args['copyrightText']
      @introductory_text = args['introductoryText']
      @short_description = args['shortDescription']
      @sidebar_text = args['sidebarText']
      @count_items = args['countItems']
      @sub_communities = args['subcommunities']
      @collections = args['collections']
      @expand = args['expand']
    end

    def to_h
      h = Hash.new
      h["handle"] = @handle
      h["name"] = @name
      h["id"] = @id
      h["type"] = @type
      h["link"] = @link
      h["logo"] = @logo
      h["parentCommunity"] = @parent_community
      h["copyrightText"] = @copyright_text
      h["introductoryText"] = @introductory_text
      h["shortDescription"] = @short_description
      h["sidebarText"] = @sidebar_text
      h["countItems"] = @count_items
      h["subcommunities"] = @sub_communities
      h["collections"] = @collections
      h["expand"] = @expand
      h
    end

  end
end
