module Dspace
  class ItemFilter
    attr_reader :category, :filter_name, :title

    def initialize(args={})
      @category = args['category']
      @filter_name = args['filter-name']
      @title = args['title']
    end

    def to_h
      {category: @category, 'filter-name': @filter_name, title: @title}
    end

  end
end
