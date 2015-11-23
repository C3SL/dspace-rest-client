module Dspace
  class Client

    def initialize(url, authenticated_token = nil)
      @url = url
      @authenticated_token = authenticated_token
    end

    def repository
      @dspace_repository ||= build_repository @rest_client
    end

    def login(username, password)
      user = JSON.generate({
                               email: username,
                               password: password
                           })

      # send login request to server and receive the token
      authenticated_token = @rest_client['/login'].post user

      # overwrite the rest_client and dspace_repository
      @rest_client = build_rest_client @url, rest_dspace_token: authenticated_token
      @dspace_repository = build_repository @rest_client

      authenticated_token
    end

    def logout
      JSON.parse @rest_client['/logout'].post []
    end

    def status
      JSON.parse @rest_client['/status'].get
    end

    def test
      JSON.parse(@rest_client['/test'].get)
    end

  end
end
