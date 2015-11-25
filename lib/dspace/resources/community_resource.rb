module Dspace
  module Resources
    class CommunityResource < ResourceKit::Resource

      # :collections GET /communities/{communityId}/collections - Returns an array of collections of the specified community.
      # :subcommunities GET /communities/{communityId}/communities - Returns an array of subcommunities of the specified community.

      resources do

        action :all, 'GET /rest/communities' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :top_communities, 'GET /rest/communities/top-communities' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :find, 'GET /rest/communities/:id' do
          handler(200) do |response|
            Dspace::Community.new(JSON.parse(response.body))
          end
        end

        action :collections, 'GET /rest/communities/:id/collections' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_collections(JSON.parse(response.body))
          end
        end
      end

    end
  end
end