require File.dirname(__FILE__) + '/dspacerestclient/request'

module DspaceRestClient

  attr_reader :dspaceurl, :headers, :cookies, :request

  def self.login (username, password)
    action = '/login'
    data = JSON.generate({:email=>username,:password=>password})
    response = self.post(:action => action, :data => data)
    @token = {:'rest-dspace-token' => @response}
    puts response
  end

  def self.logout
    action = '/logout'
    response = self.post(:action => action)
    puts response
  end

  def self.test
    action = '/test'
    response = self.post(:action => action)
    puts response
  end

  def self.status
    action = '/status'
    response = self.post(:action => action)
    puts response
  end

end
