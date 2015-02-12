module DSpaceRest

  class Bitstream

    attr_accessor :name, :bundleName,
                  :description, :format, :mimeType

    attr_reader   :id, :type, :link, :sizeBytes,
                  :parentObject, :retrieveLink, :checkSum,
                  :sequenceId, :policies

    def initialize args, request
      @id = args['id'] || ""
      @name = args['name'] || ""
      @type = args['type'] || ""
      @link = args['link'] || ""
      @bundleName = args['bundleName'] || ""
      @description = args['description'] || ""
      @format = args['format'] || ""
      @mimeType = args['mimeType'] || ""
      @sizeBytes = args['sizeBytes'] || ""
      @parentObject = args['parentObject'] || ""
      @retrieveLink = args['retrieveLink'] || ""
      @checkSum = args['checkSum'] || ""
      @sequenceId = args['sequenceId'] || ""
      @policies = args['policies'] || ""
      @expand = args['expand'] || ""
      @request = request
    end

    def to_h
      h = Hash.new
      h['id'] = @id
      h['name'] = @name
      h['type'] = @type
      h['link'] = @link
      h['bundleName'] = @bundleName
      h['description'] = @description
      h['format'] = @format
      h['mimeType'] = @mimeType
      h['sizeBytes'] = @sizeBytes
      h['parentObject'] = @parentObject
      h['retrieveLink'] = @retrieveLink
      h['checkSum'] = @checkSum
      h['sequenceId'] = @sequenceId
      h['policies'] = @policies
      h['expand'] = @expand
      h
    end

    def self.get_by_id(id, request)
      response = request["/bitstreams/#{id}"].get
      Bitstream.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/bitstreams"].get
      bitStreams = []
      JSON.parse(response).each do |bits|
        bitStreams << Bitstream.new(bits, request)
      end
      bitStreams
    end

    def get_retrieve_link
      @request.url + @retrieveLink
    end

    def retrieve
      response = @request["/bitstreams/#{id}/retrieve"].get
    end

    def put_metadata
      valid_keys=['name', 'description','sequenceId']
      form = JSON.generate(self.to_h.select { |k,v| valid_keys.include? k })
      response = @request["/bitstreams/#{id}"].put form
    end

  end

end
