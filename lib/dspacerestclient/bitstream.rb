class DspaceRestClient

  class Bitstream

    attr_accessor :id, :name, :type, :bundleName,
      :checkSum, :description, :format, :mimeType,
      :retrieveLink, :sequenceId, :sizeBytes

    def initialize args
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
    end

  end

end
