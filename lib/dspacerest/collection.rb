module DSpaceRest

  class Collection

    attr_accessor :handle, :id, :name, :type,
                  :copyrightText, :numberItems, :introductoryText,
                  :shortDescription, :sidebarText

    def initialize args
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @copyrightText = args['copyrightText']
      @numberItems = args['numberItems']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']
    end

    def self.get_by_id(id, request)
      response = request["/collections/#{id}"].get
      Collection.new(JSON.parse(response))
    end

    def self.get_all(request)
      response = request['/collections'].get
      collections = []
      JSON.parse(response).each do |coll|
        collections << Collection.new(coll)
      end
      collections
    end

  end

end
