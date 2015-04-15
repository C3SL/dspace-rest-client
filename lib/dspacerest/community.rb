module DSpaceRest
  class Community

    attr_accessor :name, :logo, :copyrightText,
                  :introductoryText, :shortDescription, :sidebarText

    attr_reader :id, :handle, :type, :link, :parentCommunity,
                :countItems, :subcommunities, :collections, :expand

    def initialize args
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @parentCommunity = args['parentCommunity']
      @copyrightText = args['copyrightText']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']
      @countItems = args['countItems']
      @subcommunities = args['subcommunities']
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
      h["parentCommunity"] = @parentCommunity
      h["copyrightText"] = @copyrightText
      h["introductoryText"] = @introductoryText
      h["shortDescription"] = @shortDescription
      h["sidebarText"] = @sidebarText
      h["countItems"] = @countItems
      h["subcommunities"] = @subcommunities
      h["collections"] = @collections
      h["expand"] = @expand
      h
    end

  end
end
