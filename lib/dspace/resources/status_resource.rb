module Dspace
  module Resources
    class StatusResource < ResourceKit::Resource

      resources do

        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :test, 'GET /rest/test' do
          handler(200) { |response| true }
        end

        action :status, 'GET /rest/status' do
          handler(200) { |response| JSON.parse(response.body) }
        end

      end

    end
  end
end
