module DSpaceRest
  class Auth

    attr_reader :token

    def initialize(request)
      @request = request
    end

    def login (username, password)
      data = JSON.generate({:email => username, :password => password})
      response = @request['/login'].post(data)
      @token = {:'rest-dspace-token' => response}
    end

    def logout
      response = @request['/logout'].post([], @token)
    end

    def status
      response = @request['/status'].get
    end

  end
end
