module DSpaceRest
  module Repositories
    class CommunityRepository < AbstractRepository

      def get_community(id)
        response = rest_client["/communities/#{id}"].get
        Community.new(JSON.parse(response))
      end

      def get_communities
        response = rest_client["/communities"].get
        communities = []
        JSON.parse(response).each do |comm|
          communities << Community.new(comm)
        end
        communities
      end

      def get_topcommunities
        response = rest_client["/communities/top-communities"].get
        communities = []
        JSON.parse(response).each do |comm|
          communities << Community.new(comm)
        end
        communities
      end

      def get_subcommunities_of(community)
        response = rest_client["/communities/#{community.id}/communities"].get
        communities = []
        JSON.parse(response).each do |comm|
          communities << Community.new(comm)
        end
        communities
      end

      def create_community(community)
        form = JSON.generate(community.to_h)
        response = rest_client["/communities"].post form
      end

      def create_subcommunity_of(community, subcommunity)
        form = JSON.generate(subcommunity.to_h)
        response = rest_client["/communities/#{community.id}/communities"].post form

        Community.new(JSON.parse(response))
      end

    end
  end
end