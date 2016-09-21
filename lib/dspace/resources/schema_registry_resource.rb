module Dspace
  module Resources
    class SchemaRegistryResource < ResourceKit::Resource

      resources do

        # default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        # default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        # default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        # default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        # default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :all, 'GET /rest/registries/schema' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_schemaregistry(JSON.parse(response.body))
          end
        end

        action :find, 'GET /rest/registries/schema/:schema_prefix' do
          query_keys :expand
          handler(200) do |response|
            Dspace::SchemaRegistry.new(JSON.parse(response.body))
          end
        end

        action :find_metadata_field, 'GET /rest/registries/metadata-fields/:field_id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Field.new(JSON.parse(response.body))
          end
        end

      end

    end
  end
end
