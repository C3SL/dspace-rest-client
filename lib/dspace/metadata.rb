module Dspace
  class Metadata
    attr_accessor :key, :value, :language

    def initialize args
      @key = args['key']
      @value = args['value']
      @language = args['language'] || nil
    end

    def to_h
      {key: @key, value: @value, language: @language}
    end

  end
end
