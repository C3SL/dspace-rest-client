module Dspace
  class Collection
    include Dspace::Builders::HashBuilder

    attr_accessor :name, :logo, :license, :copyright_text,
                  :introductory_text, :short_description, :sidebar_text

    attr_reader :id, :handle, :type, :link, :parent_community,
                :parent_community_list, :items,
                :number_items, :expand

    def initialize(args={})
      @id = args['id'] || args['uuid']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @license = args['license']
      @copyright_text = args['copyrightText'] || args['copyright_text']
      @introductory_text = args['introductoryText'] || args['introductory_text']
      @short_description = args['shortDescription'] || args['short_description']
      @sidebar_text = args['sidebarText'] || args['sidebar_text']
      @number_items = args['numberItems']
      @expand = args['expand']

      @parent_community = Dspace::Community.new(args['parentCommunity']) unless args['parentCommunity'].nil?
      @parent_community_list = Dspace::Builders::ModelBuilder.build_communities(args['parentCommunityList'])
      @items = Dspace::Builders::ModelBuilder.build_items(args['items'])
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
          parentCommunityList: @parent_community_list,
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

  end
end
