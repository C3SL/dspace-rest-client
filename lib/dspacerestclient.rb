require 'rest-client'

require File.dirname(__FILE__) + '/dspacerestclient/community'
require File.dirname(__FILE__) + '/dspacerestclient/collection'
require File.dirname(__FILE__) + '/dspacerestclient/item'
require File.dirname(__FILE__) + '/dspacerestclient/bitstream'

class DspaceRestClient

  attr_reader :dspaceurl, :headers, :token, :request

  #---------------------------------------------------
  def initialize(args)
    @dspaceurl = args[:dspaceurl] or raise ArgumentError, "must pass :dspaceurl"

    #:content_type => :json
    default_headers = {
      :accept => :json
    }
    @headers = args[:headers] || default_headers
    @token = args[:token] || {}
    @authenticated = false

    @request = RestClient::Resource.new(
      @dspaceurl,
      :verify_ssl => OpenSSL::SSL::VERIFY_NONE,
      :headers => @headers,
    )
  end
  #---------------------------------------------------

  #---------------------------------------------------
  def get_community(id)
    response = @request["/communities/#{id}"].get
    Community.new(JSON.parse(response))
  end

  def get_communities
    response = @request['/communities'].get
    communities = []
    JSON.parse(response).each do |comm|
      communities << Community.new(comm)
    end
    communities
  end
  #---------------------------------------------------

  #---------------------------------------------------
  def get_collection(id)
    response = @request["/collections/#{id}"].get
    Collection.new(JSON.parse(response))
  end

  def get_collections
    response = @request['/collections'].get
    collections = []
    JSON.parse(response).each do |coll|
      collections << Collection.new(coll)
    end
    collections
  end
  #---------------------------------------------------

  #---------------------------------------------------
  def get_item(id)
    response = @request["/items/#{id}"].get
    Item.new(JSON.parse(response))
  end

  def get_items
    response = @request['/items'].get
    items = []
    JSON.parse(response).each do |item|
      items << Item.new(item)
    end
    items
  end
  #---------------------------------------------------

  #---------------------------------------------------
  def get_bitstream(id)
    response = @request["/bitstreams/#{id}"].get
    Bitstreams.new(JSON.parse(response))
  end

  def get_bitstreams
    response = @request['/bitstreams'].get
    bitstreams = []
    JSON.parse(response).each do |bits|
      bitstreams << Bitstream.new(bits)
    end
    bitstreams
  end
  #---------------------------------------------------

  def login (username, password)
    data = JSON.generate({:email=>username,:password=>password})
    response = post('/login',data)
    @token = {:'rest-dspace-token' => response}
  end

  def logout
    post('/logout',[])
  end

  def status
    get('/status')
  end

  def test
    get('test')
  end

end
