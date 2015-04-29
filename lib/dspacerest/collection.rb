module DSpaceRest
  class Collection

    attr_accessor :name, :logo, :license, :copyright_text,
                  :introductory_text, :short_description, :sidebar_text

    attr_reader :id, :handle, :type, :link, :parent_community,
                :parent_community_list, :items,
                :number_iems, :sub_communities, :collections, :expand

    def initialize args
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @parent_community = DSpaceRest::Community.new(args['parentCommunity']) unless args['parentCommunity'].nil?
      @parent_community_list = build_communities(args['parentCommunityList']) unless args['parentCommunityList'].empty?
      @items = build_items(args['items']) unless args['items'].empty?
      @license = args['license']
      @copyright_text = args['copyrightText']
      @introductory_text = args['introductoryText']
      @short_description = args['shortDescription']
      @sidebar_text = args['sidebarText']
      @number_items = args['countItems']
      @expand = args['expand']
    end

    def to_h
      h = Hash.new
      h["id"] = @id
      h["name"] = @name
      h["handle"] = @handle
      h["type"] = @type
      h["link"] = @link
      h["logo"] = @logo
      h["parentCommunity"] = @parent_community
      h["parentCommunityList"] = @parent_community_list
      h["items"] = @items
      h["license"] = @license
      h["copyrightText"] = @copyright_text
      h["introductoryText"] = @introductory_text
      h["shortDescription"] = @short_description
      h["sidebarText"] = @sidebar_text
      h["numberItems"] = @number_items
      h["expand"] = @expand
      h
    end

    private

    def build_communities(communities=[])
      colls = []
      communities.each do |c|
        colls << DSpaceRest::Community.new(c)
      end
      colls
    end

    def build_items(items=[])
      colls = []
      items.each do |c|
        colls << DSpaceRest::Item.new(c)
      end
      colls
    end

  end
end
