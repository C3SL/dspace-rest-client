module Dspace
  module Resources
    class HierarchyResource < ResourceKit::Resource

      resources do

        default_handler(400) { raise InvalidTokenError, 'Invalid access token.' }
        default_handler(403) { raise InvalidCredentialsError, 'Wrong Dspace credentials.' }
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :all, 'GET /rest/hierarchy' do
          handler(200) do |response|
            Dspace::Site.new(JSON.parse(response.body))
          end
        end

      end
    end
  end
end
