module DSpaceRest
  module Repositories
    class AbstractRepository
      attr_reader :rest_client

      def initialize(rest_client)
        @rest_client = rest_client
      end

      protected

      def build_expand_uri(expand = nil)
        if expandable_properties.include? expand
          "expand=#{expand}"
        end
      end

      def build_parameter_uri(parameter, value = nil)
        if query_parameters.include? parameter
          "#{parameter}=#{value}"
        end
      end

    end
  end
end
