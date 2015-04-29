module DSpaceRest
  class Bitstream

    attr_accessor :name, :bundle_name,
                  :description, :format, :mime_type

    attr_reader :id, :type, :link, :size_bytes,
                :parent_object, :retrieve_link, :check_sum,
                :sequence_id, :policies

    def initialize args
      @id = args['id']
      @name = args['name']
      @type = args['type']
      @link = args['link']
      @bundle_name = args['bundleName']
      @description = args['description']
      @format = args['format']
      @mime_type = args['mimeType']
      @size_bytes = args['sizeBytes']
      @parent_object = args['parentObject']
      @retrieve_link = args['retrieveLink']
      @check_sum = args['checkSum']
      @sequence_id = args['sequenceId']
      @policies = build_policies(args['policies']) unless args['policies'].empty?
      @expand = args['expand']
    end

    def to_h
      h = Hash.new
      h['id'] = @id
      h['name'] = @name
      h['type'] = @type
      h['link'] = @link
      h['bundleName'] = @bundle_name
      h['description'] = @description
      h['format'] = @format
      h['mimeType'] = @mime_type
      h['sizeBytes'] = @size_bytes
      h['parentObject'] = @parent_object
      h['retrieveLink'] = @retrieve_link
      h['checkSum'] = @check_sum
      h['sequenceId'] = @sequence_id
      h['policies'] = @policies
      h['expand'] = @expand
      h
    end

    private

    def build_policies(policies=[])
      colls = []
      policies.each do |c|
        colls << DSpaceRest::Policy.new(c)
      end
      colls
    end

  end
end
