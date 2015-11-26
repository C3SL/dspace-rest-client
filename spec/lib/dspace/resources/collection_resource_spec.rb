require 'spec_helper'

RSpec.describe Dspace::Resources::CollectionResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::CollectionResource }

# > GET /collections - Return all collections of DSpace in array.
# > GET /collections/{collectionId} - Return collection with id.
# > GET /collections/{collectionId}/items - Return all items of collection. Use the limit parameter to control items per response (default 100) and offset for paging.
# > POST /collections/{collectionId}/items - Create posted item in collection. You must post an Item
# POST /collections/find-collection - Find collection by passed name.
# > PUT /collections/{collectionId} - Update collection. You must put Collection.
# DELETE /collections/{collectionId} - Delete collection from DSpace.
# DELETE /collections/{collectionId}/items/{itemId} - Delete item in collection.

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

    it 'Create an item' do
      expect(resource).to have_action(:create_items).that_handles(200).at_path('/rest/collections/:id/items').with_verb(:post) do |handled|
        expect(handled).to eq(true)
      end
    end 

    it 'Delete item by id' do
      expect(resource).to have_action(:delete_item).that_handles(200).at_path('/rest/collections/:id/items/:item_id').with_verb(:delete) do |handled|
        expect(handled).to eq(true)
      end
    end 
  end

end