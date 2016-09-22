module Dspace
  module Resources
    class SchemaRegistryResource < ResourceKit::Resource

      resources do

        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }

        # GET /registries/schema
        # => Return the list of metadata schemas in the registry
        action :all,
            'GET /rest/registries/schema' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_schemaregistry(JSON.parse(response.body))
          end
        end

        # GET /registries/schema/{schema_prefix}
        # => Returns the specified metadata schema
        action :find_schema,
            'GET /rest/registries/schema/:schema_prefix' do
          query_keys :expand
          handler(200) do |response|
            Dspace::SchemaRegistry.new(JSON.parse(response.body))
          end
        end

        # POST /registries/schema/
        # => Add a schema to the schema registry
        action :create_schema,
            'POST /rest/registries/schema' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) { |response| response.inspect }
        end

        # DELETE /registries/schema/{schema_id}
        # => Delete the specified schema from the schema registry
        action :delete_schema,
            'DELETE /rest/registries/schema/:schema_id' do
          handler(200) { |response| true }
        end

        # GET /registries/metadata-fields/{field_id}
        # => Return the specified metadata field
        action :find_metadata_field,
            'GET /rest/registries/metadata-fields/:field_id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Field.new(JSON.parse(response.body))
          end
        end

        # POST /registries/schema/{schema_prefix}/metadata-fields
        # => Add a metadata field to the specified schema
        action :create_metadata_field,
            'POST /rest/registries/schema/:schema_prefix/metadata-fields' do
          body { |object| JSON.generate(object.to_h) }
          handler(200) do |response|
            Dspace::Field.new(JSON.parse(response.body))
          end
        end

        # PUT /registries/metadata-fields/{field_id}
        # => Update the specified metadata field
        action :update_metadata_field,
            'GET /rest/registries/metadata-fields/:field_id' do
          query_keys :expand
          handler(200) do |response|
            Dspace::Field.new(JSON.parse(response.body))
          end
        end

        # DELETE /registries/metadata-fields/{field_id}
        # => Delete the specified metadata field from the metadata field registry
        action :delete_metadata_field,
            'DELETE /rest/registries/metadata-fields/:field_id' do
          handler(200) { |response| true }
        end

        # GET /registries/schema/{schema_prefix}/metadata-fields/{element}
        # => Returns the metadata field within a schema with an unqualified element name
        action :find_unqualified_element,
            'GET /rest/registries/schema/:schema_prefix/metadata-fields/:element' do
          query_keys :expand
          handler(200) do |response|
            Dspace::SchemaRegistry.new(JSON.parse(response.body))
          end
        end

        # GET /registries/schema/{schema_prefix}/metadata-fields/{element}/{qualifier}
        # => Returns the metadata field within a schema with a qualified element name
        action :find_qualified_element,
            'GET /rest/registries/schema/:schema_prefix/metadata-fields/:element/:qualifier' do
          handler(200) do |response|
            Dspace::Field.new(JSON.parse(response.body))
          end
        end

      end

    end
  end
end
