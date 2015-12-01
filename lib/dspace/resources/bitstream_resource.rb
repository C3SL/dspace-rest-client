module Dspace
  module Resources
    class BitstreamResource < ResourceKit::Resource

      resources do
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }

        action :all, 'GET /rest/bitstreams' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_items(JSON.parse(response.body))
          end
        end

        action :find, 'GET /rest/bitstreams/:id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Bitstream.new(JSON.parse(response.body))
          end
        end

        action :policy, 'GET /rest/bitstreams/:id/policy' do
          handler(200) do |response|
            Dspace::Policy.new(JSON.parse(response.body))
          end
        end

        action :retrive, 'GET /rest/bitstreams/:id/retrieve' do
          handler(200) { |response| response.body }
        end

        action :delete, 'DELETE /rest/bitstreams/:id' do
          handler(200, 201, 204) { |response| true }
        end

        action :delete_policy, 'DELETE /rest/bitstreams/:id/policy/:policy_id' do
          handler(200, 201, 204) { |response| true }
        end

        action :add_policy, 'POST /rest/bitstreams/:id/policy ' do
          body { |object| JSON.generate(object.to_h) }
          handler(200, 201) { |response| true }
        end

        action :update, 'PUT /rest/bitstreams/:id ' do
          body { |object| JSON.generate(object.to_h) }
          handler(200, 201) { |response| true }
        end

        action :update_data, 'PUT /rest/bitstreams/:id/data' do
          body { |upload_io| upload_io }
          handler(200, 201) { |response| true }
        end
      end

      def retrieve(args={})
        bitstream = ResourceKit::ActionInvoker.call(action(:find), self, id: args.fetch(:id))
        Dspace::Builders::TempfileBuilder.build(bitstream.name, ResourceKit::ActionInvoker.call(action(:retrive), self))
      end

    end
  end
end