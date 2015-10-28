module DSpaceRest
  module Repositories
    class AbstractRepository
      attr_reader :rest_client

      def initialize(rest_client)
        @rest_client = rest_client
      end

      protected

      def build_query_string(params)

        query_string=""

        if query_parameters.include? 'limit'
          query_string << "limit=#{params[:limit]}&"
        end

        if query_parameters.include? 'offset'
          query_string << "offset=#{params[:offset]}&"
        end

        expand_string = ""
        params[:expand].each do |expand|
          if expandable_properties.include? expand
            expand_string << "#{expand},"
          end
        end
        query_string << "expand=#{expand_string}"

        query_string
      end

    end
  end
end
