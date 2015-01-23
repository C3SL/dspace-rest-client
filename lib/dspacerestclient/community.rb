class DspaceRestClient

  class Community

    attr_accessor :handle, :id, :name, :type,
      :copyrightText, :countItems, :introductoryText,
      :shortDescription, :sidebarText

    def initialize args
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @copyrightText = args['copyrightText']
      @countItems = args['countItems']
      @introductoryText = args['introductoryText']
      @shortDescription = args['shortDescription']
      @sidebarText = args['sidebarText']
    end

  end

end
