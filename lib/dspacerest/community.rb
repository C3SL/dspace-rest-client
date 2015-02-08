module DSpaceRest

  class Community

    attr_accessor :name, :logo, :copyrightText,
                  :introductoryText, :shortDescription, :sidebarText

    attr_reader   :id, :handle, :type, :link, :parentCommunity,
                  :countItems, :subcommunities, :collections, :expand

    def initialize args, request
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
      @request = request
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

    def self.get_by_id(id, request)
      response = request["/communities/#{id}"].get
      Community.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/communities"].get
      communities = []
      JSON.parse(response).each do |comm|
        communities << Community.new(comm, request)
      end
      communities
    end

    def self.get_all_top(request)
      response = @request["/communities/top-communities"].get
      communities = []
      JSON.parse(response).each do |comm|
        communities << Community.new(comm, @request)
      end
      communities
    end

    def get_subcommunities
      response = @request["/communities/#{id}/communities"].get
      communities = []
      JSON.parse(response).each do |comm|
        communities << Community.new(comm, @request)
      end
      communities
    end

    def get_collections
      response = @request["/communities/#{id}/collections"].get
      collections = []
      JSON.parse(response).each do |coll|
        collections << Collection.new(coll, @request)
      end
      collections
    end

    def post_community
      form = JSON.generate(self.to_h)
      response = @request["/communities"].post form

      response_hash = JSON.parse(response)

      @handle = response_hash["handle"]
      @id = response_hash["id"]
      @type = response_hash["type"]
      @link = response_hash["link"]
      @parentCommunity = response_hash["parentCommunity"]
      @countItems = response_hash["countItems"]
      @subcommunities = response_hash["subcommunities"]
      @collections = response_hash["collections"]

      self
    end

    def post_subcommunity(subcommunity)
      form = JSON.generate(subcommunity.to_h)
      response = @request["/communities/#{id}/communities"].post form
      Community.new(JSON.parse(response))
    end

    def post_collection(collection)
      form = JSON.generate(collection.to_h)
      response = @request["/communities/#{id}/collections"].post form
      Collection.new(JSON.parse(response), @request)
    end

  end

end
