module DSpaceRest

  class Bitstream

    attr_accessor :id, :name, :type, :bundleName,
                  :checkSum, :description, :format, :mimeType,
                  :retrieveLink, :sequenceId, :sizeBytes

    def initialize args, request
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @bundleName = args['bundleName']
      @checkSum = args['checkSum']
      @description = args['description']
      @format = args['format']
      @mimeType = args['mimeType']
      @retrieveLink = args['retrieveLink']
      @sequenceId = args['sequenceId']
      @sizeBytes = args['sizeBytes']

      @request = request
    end


    def self.get_by_id(id, request)
      response = request["/bitstreams/#{id}"].get
      puts response
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

      array_metadata = {}
      array_metadata["name"] = @name
      array_metadata["bundleName"] = @bundleName
      array_metadata["description"] = @description

      rqst = JSON.generate(array_metadata)

      response = @request["/bitstreams/#{id}"].put rqst
    end

  end

end
