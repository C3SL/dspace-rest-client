module Dspace
  class Site
    include Dspace::Builders::HashBuilder

    attr_accessor :name

    attr_reader :id, :handle

    def initialize(args={})
      @id = args['id'] || args['uuid']
      @name = args['name']
      @handle = args['handle']
      @community_list = Dspace::Collection.new(args['parentCollection']) unless args['parentCollection'].nil?
    end

    def to_h
      {
          uuid: @id,
          name: @name,
          handle: @handle
      }
    end

  end
end
