require 'spec_helper'

RSpec.describe Dspace::Resources::CommunityResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::CommunityResource }

  it 'get all communities' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/communities')
  end

  it 'get top communities' do
    expect(resource).to have_action(:top_communities).that_handles(200).at_path('/rest/communities/top-communities')
  end

  it 'find community' do
    expect(resource).to have_action(:find).that_handles(200).at_path('/rest/communities/:id')
  end

  context "with community scope" do

    it "get collections" do
      expect(resource).to have_action(:collections).that_handles(200).at_path('/rest/communities/:id/collections')
    end

    it "get sub communities" do
      expect(resource).to have_action(:sub_communities).that_handles(200).at_path('/rest/communities/:id/communities')
    end

  end

  #it 'handles a 201 with response body' do
  #  expect(MyResourceClass).to handle_response(:create).with(status: 201, body: '{"users":[]}') do |handled|
  #    expect(handled).to all(be_kind_of(User))
  #  end
  #end


end