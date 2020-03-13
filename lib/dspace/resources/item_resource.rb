module Dspace
  module Resources
    class ItemResource < ResourceKit::Resource

      resources do

        default_handler(400) { raise InvalidTokenError, 'Invalid access token.' }
        default_handler(403) { raise InvalidCredentialsError, 'Wrong Dspace credentials.' }
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :all, 'GET /rest/items' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_items(JSON.parse(response.body))
          end
        end

        action :find, 'GET /rest/items/:id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Item.new(JSON.parse(response.body))
          end
        end

        action :find_by_metadata, 'POST /rest/items/find-by-metadata-field' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_items(JSON.parse(response.body))
          end
        end

        action :metadata, 'GET /rest/items/:id/metadata' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_metadatas(JSON.parse(response.body))
          end
        end

        action :bitstreams, 'GET /rest/items/:id/bitstreams' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_bitstreams(JSON.parse(response.body))
          end
        end

        action :delete, 'DELETE /rest/items/:id' do
          handler(200, 201, 204) { |response| true }
        end

        action :clear_metadata, 'DELETE /rest/items/:id/metadata' do
          handler(200, 201, 204) { |response| true }
        end

        action :delete_bitstream, 'DELETE /rest/items/:id/bitstreams/:bitstream_id' do
          handler(200, 201, 204) { |response| true }
        end

        action :add_metadata, 'POST /rest/items/:id/metadata' do
          body { |objects| JSON.generate(objects) }
          handler(200, 201) { |response| true }
        end

        action :add_bitstream, 'POST /rest/items/:id/bitstreams' do
          query_keys :name, :description, :bundle_name
          body { |file| file.read }
          handler(200) { |response| Dspace::Bitstream.new(JSON.parse(response.body)) }
        end

        action :update_metadata, 'PUT /rest/items/:id/metadata' do
          body { |object| JSON.generate(Dspace::Builders::ModelBuilder.models2hash(object))}
          handler(200, 201) { |response| true }
        end

      end
    end
  end
end
