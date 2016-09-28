module Dspace
  class Site
    include Dspace::Builders::HashBuilder

    attr_reader :id, :name, :handle, :community_list

    def initialize(args={})
      @id = args['id'] || args['uuid']
      @name = args['name']
      @handle = args['handle']
      @community_list = Dspace::Builders::ModelBuilder.build_communities(args['community']) unless args['community'].nil?
    end

    def to_h
      {
          uuid: @id,
          name: @name,
          handle: @handle,
          community: obj2hash(@community_list),
      }
    end

  end
end
