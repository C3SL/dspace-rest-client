module DSpaceRest

  class Community

    attr_accessor :handle, :id, :name, :type,
                  :copyrightText, :countItems, :introductoryText,
                  :shortDescription, :sidebarText

    def initialize args, request
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @copyrightText = args['copyrightText']
      @countItems = args['countItems']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']

      @request = request
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

  end

end
