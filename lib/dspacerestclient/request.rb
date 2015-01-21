class Request

  #---------------------------------------------
  def initialize
    @dspaceurl = 'https://dspacesnj3.c3sl.ufpr.br:8443/rest'
    @headers = {:accept => :json, :content_type=>:json}
    @token = {}
    @request = RestClient::Resource.new(
    dspaceurl,
    :verify_ssl => OpenSSL::SSL::VERIFY_NONE
    )
    puts "AKIIIIIII"
  end
  #---------------------------------------------

  #---------------------------------------------
  def self.get args
    @request[args[:action]].get(
    @token, :headers => @headers
    )
  end

  def self.post args
    @request[args[:action]].post(
    args[:data], @token, :headers => @headers
    )
  end
  #---------------------------------------------
  
end
