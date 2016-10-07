module Dspace
  class Report
    attr_reader :nickname, :url

    def initialize(args={})
      @nickname = args['nickname']
      @url = args['url']
    end

    def to_h
      {nickname: @nickname, url: @url}
    end

  end
end
