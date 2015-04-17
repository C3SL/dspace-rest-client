module DSpaceRest
  module Strategies
    class RestStrategy

      def initialize(rest_client)
        @rest_client = rest_client
      end

      def upload(endpoint, file)
        @rest_client[endpoint].post File.read(file)
      end

    end
  end
end