module DSpaceRest
  module Repositories
    class AbstractRepository
      attr_reader :rest_client

      def initialize(rest_client)
        @rest_client = rest_client
      end

    end
  end
end

File