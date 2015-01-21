class DspaceRestClient

  attr_reader :dspaceurl, :headers, :token, :execute

  def initialize args
    @dspaceurl = args[:dspaceurl]
    @headers = {
      :accept => :json,
      :content_type => :json
    }
    @token = {}
    @request = RestClient::Resource.new(
      @dspaceurl,
      :verify_ssl => OpenSSL::SSL::VERIFY_NONE,
      :headers => @headers
    )
  end

  def get (endpoint)
    @request[endpoint].get(@token)
  end

  def post (endpoint, data)
    @request[endpoint].post(data,@token)
  end

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
