class DspaceRestClient

  class Community

    attr_reader :handle, :id, :name, :type,
      :copyrightText, :countItems, :introductoryText,
      :shortDescription, :sidebarText

    def initialize args
      puts "COMMUNITY.INITIALIZE"

      @response = {}
      @dspaceurl = args[:dspaceurl]
      @token = args[:token] || {}
      @endpoint = args[:endpoint]

    end

    def response
      @response
    end

  end

end
