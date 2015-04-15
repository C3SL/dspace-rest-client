module DSpaceRest
  module Repositories
    class DspaceRepository < AbstractRepository

      def bitstream_repository

      end

      def collection_repository

      end

      def community_repository
        CommunityRepository.new rest_client
      end

      def item_repository

      end

      def metadata_repository

      end

    end
  end
end