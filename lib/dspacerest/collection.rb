module DSpaceRest
  class Collection

    attr_accessor :name, :logo, :license, :copyright_text,
                  :introductory_text, :short_description, :sidebar_text

    attr_reader :id, :handle, :type, :link, :parent_community,
                :parent_community_list, :items,
                :number_items, :expand

    def initialize args
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @license = args['license']
      @copyright_text = args['copyrightText']
      @introductory_text = args['introductoryText']
      @short_description = args['shortDescription']
      @sidebar_text = args['sidebarText']
      @number_items = args['numberItems']
      @expand = args['expand']

      @parent_community = DSpaceRest::Community.new(args['parentCommunity']) unless args['parentCommunity'].nil?
      @parent_community_list = build_communities(args['parentCommunityList']) unless args['parentCommunityList'].nil?
      @items = build_items(args['items']) unless args['items'].nil?
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
          parentCommunitList: @parent_community_list,
          items: obj2hash(@items),
          license: @license,
          copyrightText: @copyright_text,
          introductoryText: @introductory_text,
          shortDescription: @short_description,
          sidebarText: @sidebar_text,
          numberItems: @number_items,
          expand: @expand
      }

      h
    end

    private

    def build_communities(communities=[])
      return communities if communities.nil?
      colls = []
      communities.each do |c|
        colls << DSpaceRest::Community.new(c)
      end
      colls
    end

    def build_items(items=[])
      return items if items.nil?
      colls = []
      items.each do |c|
        colls << DSpaceRest::Item.new(c)
      end
      colls
    end

    def obj2hash(list)
      DSpaceRest::Builders::HashBuilder.models2hash list
    end

  end
end
