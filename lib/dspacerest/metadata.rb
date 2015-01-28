module DSpaceRest

  class Metadata

    attr_accessor :key, :value, :language

    def initialize args
      @key = args['key']
      @value = args['value']
      @language = args['language']
    end

    def to_h
      return {"key"=>@key, "value"=>@value, "language"=>@language}
    end
  end

end
