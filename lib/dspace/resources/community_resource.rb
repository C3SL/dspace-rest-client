module Dspace
  module Resources
    class CommunityResource < ResourceKit::Resource

      # :all GET /communities - Return an array of all communities in DSpace.
      # :top_communities GET /communities/ top-communities - Returns an array of all top-leve communities in DSpace.
      # :find GET /communities/{communityId} - Returns a community with the specified ID.
      # :collections GET /communities/{communityId}/collections - Returns an array of collections of the specified community.
      # :subcommunities GET /communities/{communityId}/communities - Returns an array of subcommunities of the specified community.

      resources do
        action :all, 'GET /communities' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :top_communities, 'GET /communities/top-communities' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end

        action :find, 'GET /communities/:id' do
          handler(200) do |response|
            Dspace::Community.new(JSON.parse(response.body))
          end
        end



      end

    end
  end
end