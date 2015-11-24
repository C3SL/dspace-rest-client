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
      @parent_community_list = DSpaceRest::Builders::ModelBuilder.build_communities(args['parentCommunityList'])
      @items = DSpaceRest::Builders::ModelBuilder.build_items(args['items'])
    end

    def to_h
      {
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
    end

    private

    def obj2hash(list)
      DSpaceRest::Builders::HashBuilder.models2hash list
    end

  end
end