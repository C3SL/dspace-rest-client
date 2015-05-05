module DSpaceRest
  module Repositories
    class DspaceRepository < AbstractRepository

      def bitstream_repository
        BitstreamRepository.new rest_client
      end

      def collection_repository
        CollectionRepository.new rest_client
      end

      def community_repository
        CommunityRepository.new rest_client
      end

      def item_repository
        ItemRepository.new rest_client
      end

      def metadata_repository
        MetadataRepository.new rest_client
      end

    end
  end
end