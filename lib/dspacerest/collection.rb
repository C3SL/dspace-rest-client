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

    def obj2hash(list)
      hash = []
      list.each do |m|
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

    def build_items(items=[])
      colls = []
      items.each do |c|
        colls << DSpaceRest::Item.new(c)
      end
      colls
    end

  end
end
