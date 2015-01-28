module DSpaceRest

  class Item

    attr_accessor :handle, :id, :name, :type,
                  :archived, :lastModified, :withdrawn,
                  :metadata

    def initialize args, request
      @handle = args['handle']
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @archived = args['archived']
      @lastModified = args['lastModified']
      @withdrawn = args['withdrawn']

      @metadata = Hash.new

      @request = request
    end

    def self.get_by_id(id, request)
      response = request["/items/#{id}"].get
      Item.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/items"].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item, request)
      end
      items
    end

    def get_metadata
      response = @request["/items/#{id}/metadata"].get
      JSON.parse(response).each do |m|
        @metadata[m["key"]] = Metadata.new(m)
      end
      @metadata
    end

    def get_bitstreams
      response = @request["/items/#{id}/bitstreams"].get
      bitstreams = []
      JSON.parse(response).each do |bits|
        bitstreams << Bitstream.new(bits, @request)
      end
      bitstreams
    end

    def put_metadata
      array_metadata = []
      @metadata.each_value do |m|
        array_metadata << m.to_h
      end
      rqst = JSON.generate(array_metadata)
      response = @request["/items/#{id}/metadata"].put rqst
    end

    def post_bitstream(file)
      response = @request["/items/#{id}/bitstreams"].post File.read(file)
      Bitstream.new(JSON.parse(response), @request)
    end

  end

end
