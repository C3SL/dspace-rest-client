module Dspace
  class Schema
    include Dspace::Builders::HashBuilder

    attr_accessor :namespace, :prefix, :expand

    attr_reader :id, :fields

    def initialize(args={})
      @id = args['schemaID']
      @namespace = args['namespace']
      @prefix = args['prefix']
      @expand = args['expand']
      @fields = Dspace::Builders::ModelBuilder.build_fields(args['fields'])
    end

    def to_h
      {
          schemaID: @id,
          namespace: @namespace,
          prefix: @prefix,
          expand: @expand,
          fields: @fields
      }
    end

    def add_field(name, element, description)
      f = {}
      f['name'] = name
      f['element'] = element
      f['description'] = description

      @fields << Dspace::Field.new(f)
      @fields
    end

    def reset_fields
      @fields = []
    end

  end
end
