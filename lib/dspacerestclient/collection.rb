class DspaceRestClient

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

  end

end
