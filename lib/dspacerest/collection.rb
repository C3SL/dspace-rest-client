module DSpaceRest

  class Collection

    attr_accessor :handle, :id, :name, :type,
                  :copyrightText, :numberItems, :introductoryText,
                  :shortDescription, :sidebarText

    def initialize args, request
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @copyrightText = args['copyrightText']
      @numberItems = args['numberItems']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']

      @request = request
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

    def items
      response = @request["/collections/#{id}/items"].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item, @request)
      end
      items
    end

  end

end
