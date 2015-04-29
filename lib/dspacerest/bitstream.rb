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
      h = {
          id: @id,
          name: @name,
          type: @type,
          link: @link,
          bundleName: @bundle_name,
          description: @description,
          format: @format,
          mimeType: @mime_type,
          sizeBytes: @size_bytes,
          parentObject: @parent_object,
          retrieveLink: @retrieve_link,
          checkSum: @check_sum,
          sequenceId: @sequence_id,
          policies: @policies,
          expand: @expand
      }

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
