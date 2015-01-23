class DspaceRestClient

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

  end

end
