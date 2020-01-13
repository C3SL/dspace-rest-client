module Dspace
  module Resources
    class BitstreamResource < ResourceKit::Resource

      resources do

        default_handler(400) { raise InvalidTokenError, 'Invalid access token.' }
        default_handler(403) { raise InvalidCredentialsError, 'Wrong Dspace credentials.' }
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        action :all, 'GET /rest/bitstreams' do
          query_keys :expand, :limit, :offset
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_bitstreams(JSON.parse(response.body))
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

        action :retrieve, 'GET /rest/bitstreams/:id/retrieve' do
          handler(200) { |response| response.body }
        end

        action :delete, 'DELETE /rest/bitstreams/:id' do
          handler(200, 201, 204) { |response| true }
        end

        action :delete_policy, 'DELETE /rest/bitstreams/:id/policy/:policy_id' do
          handler(200, 201, 204) { |response| true }
        end

        action :add_policy, 'POST /rest/bitstreams/:id/policy' do
          body { |object| JSON.generate(object.to_h) }
          handler(200, 201) { |response| true }
        end

        action :update, 'PUT /rest/bitstreams/:id' do
          body { |object| JSON.generate(object.to_h) }
          handler(200, 201) { |response| true }
        end

        action :update_data, 'PUT /rest/bitstreams/:id/data' do
          body { |file| file.read }
          handler(200, 201) { |response| true }
        end
      end

      def retrieve(args={})
        bitstreams_path = args.fetch(:bitstreams_path, nil)
        bitstream = ResourceKit::ActionInvoker.call(action(:find), self, id: args.fetch(:id))
        return nil if bitstream.is_a? String
        Dspace::Builders::TempfileBuilder.build(bitstream_filename(bitstream), ResourceKit::ActionInvoker.call(action(:retrieve), self, id: bitstream.id), bitstreams_path)
      end

      private

      def bitstream_filename(bitstream)
        name = bitstream.try(:name)
        name = bitstream.id.to_s if !name || name.empty?
        name
      end

    end
  end
end
