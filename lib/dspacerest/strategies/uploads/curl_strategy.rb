#require 'curl'

module DSpaceRest
  module Strategies
    module Uploads
      class CurlStrategy

        def initialize(host_url, token)
          @host_url = host_url
          @token = token
        end

        def upload(endpoint, file)
          c = Curl::Easy.new(@host_url.concat(endpoint))
          c.headers['Accept'] = 'application/json'
          c.headers['rest-dspace-token'] = @token

          c.multipart_form_post = true
          c.ssl_verify_peer = false
          c.http_post(Curl::PostField.file('file', file))

          c.body_str
        end
      end
    end
  end
end