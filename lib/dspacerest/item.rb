module DSpaceRest

  class Item

    attr_accessor :handle, :id, :name, :type,
                  :archived, :lastModified, :withdrawn

    def initialize args
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @archived = args['archived']
      @lastModified = args['lastModified']
      @withdrawn = args['withdrawn']
    end

    def self.get_by_id(id, request)
      response = request["/items/#{id}"].get
      Item.new(JSON.parse(response))
    end

    def self.get_all(request)
      response = request['/items'].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item)
      end
      items
    end

  end

end
