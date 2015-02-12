require 'rest-client'

module DSpaceRest

  class Client

    attr_reader :request

    #---------------------------------------------------
    def initialize(args)
      @dspaceurl = args[:dspaceurl] or raise ArgumentError, "must pass :dspaceurl"

      @headers = Hash.new
      @headers[:content_type] = :json
      @headers[:accept] = :json

      set_request @headers
    end
    #---------------------------------------------------

    #---------------------------------------------------
    def set_request(headers)
      @request = RestClient::Resource.new(
        @dspaceurl,
        :verify_ssl => OpenSSL::SSL::VERIFY_NONE,
        :headers => headers
      )
    end

    def login (username, password)
      user_info = JSON.generate({
        :email => username,
        :password => password
      })
      response = @request['/login'].post user_info
      @headers[:rest_dspace_token] = response
      set_request @headers
    end

    def logout
      response = @request['/logout'].post [], @token
    end

    def status
      response = @request['/status'].get
    end

    def test
      response = @request['/test'].get
    end
    #---------------------------------------------------

    #---------------------------------------------------
    def new_community
      Community.new "", @request
    end

    def get_community(id)
      Community.get_by_id id, @request
    end

    def get_communities
      Community.get_all @request
    end

    def get_topcommunities
      Community.get_all_top @request
    end

    def new_collection
      Collection.new "", @request
    end

    def get_collection(id)
      Collection.get_by_id id, @request
    end

    def get_collections
      Collection.get_all @request
    end

    def new_item
      Item.new "", @request
    end

    def get_item(id)
      Item.get_by_id id, @request
    end

    def get_items
      Item.get_all @request
    end

    def get_bitstream(id)
      Bitstream.get_by_id id, @request
    end

    def get_bitstreams
      Bitstream.get_all @request
    end
    #---------------------------------------------------

  end
end
