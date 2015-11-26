module Dspace
  module Resources
    class CommunityResource < ResourceKit::Resource

      resources do
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }

        action :all, 'GET /rest/communities' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :top_communities, 'GET /rest/communities/top-communities' do
          query_keys :expand
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
          query_keys :expand
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_collections(JSON.parse(response.body))
          end
        end

        action :sub_communities, 'GET /rest/communities/:id/communities' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :create, 'POST /rest/communities' do
          body { |object| JSON.generate(object.to_h) }
          handler(200, 201) { |response| true }
        end

      end
    end
  end
end