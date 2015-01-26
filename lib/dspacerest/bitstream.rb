module DSpaceRest

  class BitStream

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
      Bitstreams.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/bitstreams"].get
      bitStreams = []
      JSON.parse(response).each do |bits|
        bitStreams << Bitstream.new(bits, request)
      end
      bitStreams
    end

  end

end
