require 'rest-client'

module DSpaceRest

  class Client

    attr_reader :request

    #---------------------------------------------------
    def initialize(args)
      dspaceurl = args[:dspaceurl] or raise ArgumentError, "must pass :dspaceurl"

      # build http header
      default_headers = {
          :content_type => :json,
          :accept => :json
      }
      headers = args[:headers] || default_headers

      @request = RestClient::Resource.new(
          dspaceurl,
          :verify_ssl => OpenSSL::SSL::VERIFY_NONE,
          :headers => headers,
      )
    end


    def test
      response = @request['/test'].get
    end


    def get_community(id)
      Community.get_by_id id, @request
    end

    def get_communities
      Community.get_all @request
    end

    def get_collection(id)
      Collection.get_by_id id, @request
    end

    def get_collections
      Collection.get_all @request
    end

    def get_item(id)
      Item.get_by_id id, @request
    end

    def get_items
      Item.get_all @request
    end

    def get_bitstream(id)
      BitStream.get_by_id id, @request
    end

    def get_bitstreams
      BitStream.get_all @request
    end

  end
end
