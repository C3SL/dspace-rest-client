class CommunityResource < ResourceKit::Resource

  resources do
    action :all, 'GET /communities' do
      handler(:success) do |response|
        Dspace::Builders::ModelBuilder.build_communities(JSON.parse(response.body))
      end
    end
  end

end