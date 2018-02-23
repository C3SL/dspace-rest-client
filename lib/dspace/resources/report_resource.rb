module Dspace
  module Resources
    class ReportResource < ResourceKit::Resource

      resources do

        default_handler(400) { raise InvalidTokenError, 'Invalid access token.' }
        default_handler(403) { raise InvalidCredentialsError, 'Wrong Dspace credentials.' }
        default_handler(401) { raise NotAuthorizedError, 'This request requires authentication' }
        default_handler(404) { raise NotFoundError, 'The specified object doesn\'t exist' }
        default_handler(405) { raise MethodNotAllowedError, 'Wrong request method (GET,POST,PUT,DELETE) or wrong data format (JSON/XML)' }
        default_handler(415) { raise UnsupportedMediaTypeError, 'Missing "Content-Type: application/json" or "Content-Type: application/xml" request header' }
        default_handler(500) { raise ServerError, 'Likely a SQLException, IOException, more details in the logs' }
        default_handler { |response| raise StandardError, "#{response.inspect}" }


        # GET /reports
        # => Return a list of report tools built on the rest api
        # NOT SUPPORTED: DSpace route returns XML instead of JSON

        # GET /reports/{nickname}
        # => Return a redirect to a specific report
        # NOT SUPPORTED: DSpace route redirects to a HTML page

        # GET /filters
        # => Return a list of use case filters available for quality control reporting
        action :filters,
            'GET /rest/filters' do
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_item_filters(JSON.parse(response.body))
          end
        end

        # GET /filtered-collections
        # => Return collections and item counts based on pre-defined filters
        action :filtered_collections,
            'GET /rest/filtered-collections' do
          query_keys :limit, :offset, :expand, :filters
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_collections(JSON.parse(response.body))
          end
        end

        # GET /filtered-collections/{collection_id}
        # => Return a specific collection based on pre-defined filters
        action :filtered_collections_by_id,
            'GET /rest/filtered-collections/:collection_id' do
          query_keys :limit, :offset, :expand, :filters
          handler(200) do |response|
            Dspace::Collection.new(JSON.parse(response.body))
          end
        end

        # GET /filtered-items
        # => Retrieve a set of items based on a metadata query and a set of filters
        action :filtered_items,
            'GET /rest/filtered-items' do
          query_keys :'collSel[]', :'query_field[]', :'query_op[]', :'query_val[]', :limit, :offset, :expand, :filters
          handler(200) do |response|
            Dspace::Builders::ModelBuilder.build_items(JSON.parse(response.body)['items'])
          end
        end

      end

    end
  end
end
