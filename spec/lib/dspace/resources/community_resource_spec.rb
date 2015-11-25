require 'spec_helper'

RSpec.describe Dspace::Resources::CommunityResource, resource_kit: true do

  it 'has an all action' do
    expect(Dspace::Resources::CommunityResource).to have_action(:all).that_handles(200).at_path('/communities')
  end

  it 'has an top communities action' do
    expect(Dspace::Resources::CommunityResource).to have_action(:top_communities).that_handles(200).at_path('/communities/top-communities')
  end

  it 'has find community action' do
    expect(Dspace::Resources::CommunityResource).to have_action(:find).that_handles(200).at_path('/communities/:id')
  end

  #it 'handles a 201 with response body' do
  #  expect(MyResourceClass).to handle_response(:create).with(status: 201, body: '{"users":[]}') do |handled|
  #    expect(handled).to all(be_kind_of(User))
  #  end
  #end


end