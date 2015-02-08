module DSpaceRest

  class Collection

    attr_accessor :name, :logo, :license, :copyrightText,
                  :introductoryText, :shortDescription, :sidebarText

    attr_reader   :id, :handle, :type, :link, :parentCommunity,
                  :parentCommunityList, :items,
                  :numberItems, :subcommunities, :collections, :expand

    def initialize args, request
      @id = args['id']
      @name = args['name']
      @handle = args['handle']
      @type = args['type']
      @link = args['link']
      @logo = args['logo']
      @parentCommunity = args['parentCommunity']
      @parentCommunityList = args['parentCommunityList']
      @items = args['items']
      @license = args['license']
      @copyrightText = args['copyrightText']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']
      @numberItems = args['countItems']
      @expand = args['expand']
      @request = request
    end

    def to_h
      h = Hash.new
      h["id"] = @id
      h["name"] = @name
      h["handle"] = @handle
      h["type"] = @type
      h["link"] = @link
      h["logo"] = @logo
      h["parentCommunity"] = @parentCommunity
      h["parentCommunityList"] = @parentCommunityList
      h["items"] = @items
      h["license"] = @license
      h["copyrightText"] = @copyrightText
      h["introductoryText"] = @introductoryText
      h["shortDescription"] = @shortDescription
      h["sidebarText"] = @sidebarText
      h["numberItems"] = @numberItems
      h["expand"] = @expand
      h
    end

    def self.get_by_id(id, request)
      response = request["/collections/#{id}"].get
      Collection.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/collections"].get
      collections = []
      JSON.parse(response).each do |coll|
        collections << Collection.new(coll, request)
      end
      collections
    end

    def get_items
      response = @request["/collections/#{id}/items"].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item, @request)
      end
      items
    end

    def post_item(item)

      form_array = []
      item.metadata.each_value do |m|
        form_array << m.to_h
      end
      form = JSON.generate({"metadata" => form_array})

      response = @request["/collections/#{id}/items"].post form

      Item.new(JSON.parse(response), @request)
    end

  end

end
