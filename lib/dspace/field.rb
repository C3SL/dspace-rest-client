module Dspace
  class Field
    include Dspace::Builders::HashBuilder

    attr_accessor :name, :element, :description, :qualifier

    attr_reader :id, :parentSchema, :expand

    def initialize(args={})
      @id = args['fieldId']
      @name = args['name']
      @element = args['element']
      @description = args['description']
      @qualifier = args['qualifier']
      @parentSchema = args['parentSchema']
      @expand = args['expand']
    end

    def to_h
      {
        fieldId: @id,
        name: @name,
        element: @element,
        description: @description,
        qualifier: @qualifier,
        parentSchema: @parentSchema,
        expand: @expand
      }
    end

  end
end
