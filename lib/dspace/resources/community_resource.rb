module Dspace
  module Resources
    class CommunityResource < ResourceKit::Resource

      resources do

        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :all, 'GET /rest/communities' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :top_communities, 'GET /rest/communities/top-communities' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :find, 'GET /rest/communities/:id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Community.new(JSON.parse(response.body))
          end
        end

        action :collections, 'GET /rest/communities/:id/collections' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_collections(JSON.parse(response.body))
          end
        end

        action :sub_communities, 'GET /rest/communities/:id/communities' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :create, 'POST /rest/communities' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) { |response| Dspace::Community.new(JSON.parse(response.body)) }
        end

        action :create_subcommunity, 'POST /rest/communities/:id/communities' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) { |response| Dspace::Community.new(JSON.parse(response.body)) }
        end

        action :create_collection, 'POST /rest/communities/:id/collections' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) { |response| Dspace::Collection.new(JSON.parse(response.body)) }
        end

        action :update, 'PUT /rest/communities/:id' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) { |response| true }
        end

        action :delete, 'DELETE /rest/communities/:id' do
          handler(200) { |response| true }
        end

        action :delete_collection, 'DELETE /rest/communities/:id/collections/:collection_id' do
          handler(200) { |response| true }
        end

        action :delete_subcommunity, 'DELETE /rest/communities/:id/communities/:subcommunity_id' do
          handler(200) { |response| true }
        end

      end
    end
  end
end
