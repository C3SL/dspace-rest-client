module Dspace
  module Resources
    class CommunityResource < ResourceKit::Resource

      resources do
        action :all, 'GET /communities' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
          end
        end
      end

    end
  end
end