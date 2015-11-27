require 'spec_helper'

RSpec.describe Dspace::Resources::CollectionResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::CollectionResource }

  it 'get all collection' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/collections').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Collection))
    end
  end

  it 'find collection by id' do
    expect(resource).to have_action(:find).that_handles(200).at_path('/rest/collections/:id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Collection)
    end
  end   

  it 'Update collection' do
    expect(resource).to have_action(:delete).that_handles(200).at_path('/rest/collections/:id').with_verb(:delete) do |handled|
      expect(handled).to eq(true)
    end
  end

  it 'Delete collection' do
    expect(resource).to have_action(:update).that_handles(200).at_path('/rest/collections/:id').with_verb(:put) do |handled|
      expect(handled).to eq(true)
    end
  end 

  context 'collection scope' do
    it 'get all items' do
      expect(resource).to have_action(:items).that_handles(200).at_path('/rest/collections/:id/items').with_verb(:get) do |handled|
        expect(handled).to all(be_kind_of(Dspace::Item))
      end
    end 

    it 'create an item' do
      expect(resource).to have_action(:create_item).that_handles(200).at_path('/rest/collections/:id/items').with_verb(:post) do |handled|
        expect(handled).to eq(true)
      end
    end 

    it 'delete item by id' do
      expect(resource).to have_action(:delete_item).that_handles(200).at_path('/rest/collections/:id/items/:item_id').with_verb(:delete) do |handled|
        expect(handled).to eq(true)
      end
    end 
  end

end