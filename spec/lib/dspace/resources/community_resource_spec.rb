require 'spec_helper'

RSpec.describe Dspace::Resources::CommunityResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::CommunityResource }

  it 'get all communities' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/communities').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Community))
    end
  end

  it 'get top communities' do
    expect(resource).to have_action(:top_communities).that_handles(200).at_path('/rest/communities/top-communities').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Community))
    end
  end

  it 'find community' do
    expect(resource).to have_action(:find).that_handles(200).at_path('/rest/communities/:id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Community)
    end
  end

  it 'create a new top-level community' do
    expect(resource).to have_action(:create).that_handles(200,201).at_path('/rest/communities').with_verb(:post) do |handled|
      expect(handled).to eq(true)
    end
  end

  context "with community scope" do

    it "get collections" do
      expect(resource).to have_action(:collections).that_handles(200).at_path('/rest/communities/:id/collections').with_verb(:get) do |handled|
        expect(handled).to all(be_kind_of(Dspace::Collection))
      end
    end

    it "get sub communities" do
      expect(resource).to have_action(:sub_communities).that_handles(200).at_path('/rest/communities/:id/communities').with_verb(:get) do |handled|
        expect(handled).to all(be_kind_of(Dspace::Community))
      end
    end

    it 'create a sub-community' do
      expect(resource).to have_action(:create_subcommunity).that_handles(200,201).at_path('/rest/communities/:id/communities').with_verb(:post) do |handled|
        expect(handled).to eq(true)
      end
    end



    it 'update a community' do
      expect(resource).to have_action(:update).that_handles(200,201).at_path('/rest/communities/:id').with_verb(:put) do |handled|
        expect(handled).to eq(true)
      end
    end

  end

  #it 'handles a 201 with response body' do
  #  expect(MyResourceClass).to handle_response(:create).with(status: 201, body: '{"users":[]}') do |handled|
  #    expect(handled).to all(be_kind_of(User))
  #  end
  #end


end