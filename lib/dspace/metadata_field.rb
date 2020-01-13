module Dspace
  class MetadataField
    include Dspace::Builders::HashBuilder

    attr_accessor :name, :element, :qualifier, :description

    attr_reader :id, :parent_schema, :expand

    def initialize(args={})
      @id = args['fieldId']
      @name = args['name']
      @parent_schema = args['parentSchema'] || args['parent_schema']
      @element = args['element']
      @qualifier = args['qualifier']
      @description = args['description']
      @expand = args['expand']
    end

    def to_h
      {
        fieldId: @id,
        name: @name,
        parentSchema: @parent_schema,
        element: @element,
        qualifier: @qualifier,
        description: @description,
        expand: @expand
      }
    end

  end
end
