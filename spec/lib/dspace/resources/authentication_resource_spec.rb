require 'spec_helper'

RSpec.describe Dspace::Resources::AuthenticationResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::AuthenticationResource }

  context 'login' do
    it 'raise an exception when credentials are wrong' do
      expect(resource).to have_action(:login).that_handles(403).at_path('/rest/login').with_verb(:post) do |handled|
        expect(handled).to raise_error(Dspace::InvalidCredentialsError)
      end
    end

    it 'returns an access token' do
      expect(resource).to have_action(:login).that_handles(200, 201).at_path('/rest/login').with_verb(:post) do |handled|
        expect(handled).to be_kind_of(String)
      end
    end
  end

  context 'logout' do
    it 'raise an exception when access token is invalid' do
      expect(resource).to have_action(:logout).that_handles(400).at_path('/rest/logout').with_verb(:post) do |handled|
        expect(handled).to raise_error(Dspace::InvalidTokenError)
      end
    end

    it 'performs the action' do
      expect(resource).to have_action(:logout).that_handles(200, 201, 203, 204).at_path('/rest/logout').with_verb(:post) do |handled|
        expect(handled).to eq(true)
      end
    end
  end

end