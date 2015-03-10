require 'curb'

module DSpaceRest

  class Item

    attr_accessor :name, :archived, :withdrawn

    attr_reader   :id, :handle, :type, :link, :lastModified,
                  :parentCollection, :parentCollectionList, :bitstreams,
                  :expand, :metadata

    def initialize args, request
      @id = args['id'] || ""
      @name = args['name'] || ""
      @handle = args['handle'] || ""
      @type = args['type'] || ""
      @link = args['link'] || ""
      @lastModified = args['lastModified'] || ""
      @parentCollection = args['parentCollection'] || ""
      @parentCollectionList = args['parentCollectionList'] || ""
      @parentCommunityList = args['parentCommunityList'] || ""
      @bitstreams = args['bitstreams'] || ""
      @archived = args['archived'] || ""
      @withdrawn = args['withdrawn'] || ""
      @expand = args['expand'] || ""
      @metadata = []
      @request = request
    end

    def to_h
      h = Hash.new
      h["id"] = @id
      h["name"] = @name
      h["handle"] = @handle
      h["type"] = @type
      h["link"] = @link
      h["lastModified"] = @lastModified
      h["parentCollection"] = @parentCollection
      h["parentCollectionList"] = @parentCollectionList
      h["parentCommunityList"] = @parentCommunityList
      h["bitstreams"] = @bitstreams
      h["archived"] = @archived
      h["withdrawn"] = @withdrawn
      h["expand"] = @expand

      if !@metadata.empty?
        metadata_array = []
        @metadata.each do |m|
          metadata_array << m.to_h
        end
        h["metadata"] = metadata_array
      end

      h
    end

    def self.get_by_id(id, request)
      response = request["/items/#{id}"].get
      Item.new(JSON.parse(response), request)
    end

    def self.get_all(request)
      response = request["/items"].get
      items = []
      JSON.parse(response).each do |item|
        items << Item.new(item, request)
      end
      items
    end

    def get_metadata
      response = @request["/items/#{id}/metadata"].get
      JSON.parse(response).each do |m|
        @metadata << Metadata.new(m)
      end
      @metadata
    end

    def get_bitstreams
      response = @request["/items/#{id}/bitstreams"].get
      bitstreams = []
      JSON.parse(response).each do |bits|
        bitstreams << Bitstream.new(bits, @request)
      end
      bitstreams
    end

    def get_parentcollection
      response = @request["/items/#{id}\?expand\=parentCollection"].get
      Collection.new(JSON.parse(response)['parentCollection'], @request)
    end

    def put_metadata
      form = JSON.generate(self.to_h["metadata"])
      response = @request["/items/#{id}/metadata"].put form
    end

    def post_bitstream(file)
      #response = upload_via_rest("/items/#{id}/bitstreams", file)
      response = upload_via_curl("/items/#{id}/bitstreams", file)
      Bitstream.new(JSON.parse(response), @request)
    end

    def delete_item
      response = @request["/items/#{id}"].delete
    end

    #---------------------------------------------------
    def set_metadata(key,value,language)
      m = {}
      m['key'] = key
      m['value'] = value
      m['language'] = language || ""
      @metadata << Metadata.new(m)
      @metadata
    end

    def reset_metadata
  		@metadata = []
  	end
    #---------------------------------------------------

    private

      def upload_via_rest(endpoint, file)
        @request[endpoint].post File.read(file)
      end

      def upload_via_curl(endpoint, file)
        dspaceurl = @request.url
        token = @request.headers[:rest_dspace_token]

        c = Curl::Easy.new("#{dspaceurl}#{endpoint}")

        c.headers['Accept'] = 'application/json'
        c.headers['rest-dspace-token'] = token

        c.multipart_form_post = true
        c.ssl_verify_peer = false

        c.http_post(Curl::PostField.file('thing[file]', file))

        c.body_str
      end

  end

end
