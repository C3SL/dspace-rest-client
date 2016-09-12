module Dspace
  class Client
    DSPACE_API = 'https://demo.dspace.org'

    attr_reader :access_token

    def initialize(options = {})
      @access_token = options.with_indifferent_access[:access_token]
      @dspace_api = options.with_indifferent_access[:dspace_api]
      @logger = options.with_indifferent_access[:logger]
    end

    def connection
      Faraday.new(connection_options) do |req|
        req.request :multipart
        req.request :url_encoded
        req.use(Faraday::Response::Logger, @logger) unless @logger.nil?
        req.adapter :net_http_persistent
      end
    end

    def self.resources
      {
          bitstreams: ::Dspace::Resources::BitstreamResource,
          items: ::Dspace::Resources::ItemResource,
          collections: ::Dspace::Resources::CollectionResource,
          communities: ::Dspace::Resources::CommunityResource,
          status: ::Dspace::Resources::StatusResource,
          authentication: ::Dspace::Resources::AuthenticationResource
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
      @access_token = resource(:authentication).login(email: email, password: password)
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
          ssl: {
              verify: false
          },
          headers: {
              content_type: 'application/json',
              accept: 'application/json',
              'rest-dspace-token' => access_token.to_s,
              user_agent: "dspace-rest-client #{Dspace::VERSION}"
          }
      }
    end
  end
end
