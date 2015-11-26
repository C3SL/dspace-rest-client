module Dspace
  class Client
    DSPACE_API = 'https://demo.dspace.org'

    attr_reader :access_token

    def initialize(options = {})
      @access_token = options.with_indifferent_access[:access_token]
      @dspace_api = options.with_indifferent_access[:dspace_api]
    end

    def connection
      Faraday.new(connection_options) do |req|
        req.adapter :net_http
      end
    end

    def self.resources
      {
          items: ItemResource,
          collections: CollectionResource,
          communities: CommunityResource,
          status: StatusResource,
          authentication: AuthenticationResource
      }
    end

    def method_missing(name, *args, &block)
      resource(name) || super
    end

    def resources
      @resources ||= {}
    end

    def is_running?
      resource(:status).test
    end

    def login(email, password)
      @access_token = resource(:authentication).login(email, password)
    end

    def logout
      resource(:authentication).logout
      @access_token = nil
    end

    private

    def resource(name)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(connection: connection)
        resources[name]
      end
    end

    def connection_options
      {
          url: @dspace_api || DSPACE_API,
          headers: {
              content_type: 'application/json',
              'rest-dspace-token' => access_token.to_s
          }
      }
    end
  end
end