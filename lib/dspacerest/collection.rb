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

    def get_items
      response = @request["/collections/#{id}/items"].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item, @request)
      end
      items
    end

    def post_item(item)
      array_metadata = []
      item.metadata.each_value do |m|
        array_metadata << m.to_h
      end
      rqst = JSON.generate({"metadata" => array_metadata})

      response = @request["/collections/#{id}/items"].post rqst

      Item.new(JSON.parse(response), @request)
    end

  end

end
