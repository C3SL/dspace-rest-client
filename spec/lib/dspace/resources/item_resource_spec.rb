require 'spec_helper'

RSpec.describe Dspace::Resources::ItemResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::ItemResource }

# > GET /items - Return list of items.
# > GET /items/{item id} - Return item.
# > GET /items/{item id}/metadata - Return item metadata.
# > GET /items/{item id}/bitstreams - Return item bitstreams.  Use the limit parameter to control items per response (default 100) and offset for paging.
# POST /items/find-by-metadata-field - Find items by metadata entry. You must post a MetadataEntry.  DS-2501 - wrong SQL in REST /items/find-by-metadata-field CLOSED
# > POST /items/{item id}/metadata - Add metadata to item. You must post an array of MetadataEntry
# > POST /items/{item id}/bitstreams - Add bitstream to item. You must post a Bitstream
# PUT /items/{item id}/metadata - Update metadata in item. You must put a MetadataEntry
# > DELETE /items/{item id} - Delete item.
# > DELETE /items/{item id}/metadata - Clear item metadata.
# > DELETE /items/{item id}/bitstreams/{bitstream id} - Delete item bitstream.

  it 'get all items' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/items').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Item))
    end
  end

  it 'find item by id' do
    expect(resource).to have_action(:find).that_handles(200).at_path('/rest/items/:id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Item)
    end
  end

  it 'Delete item' do
    expect(resource).to have_action(:delete).that_handles(200).at_path('/rest/items/:id').with_verb(:delete) do |handled|
      expect(handled).to eq(true)
    end
  end

  context 'Item scope' do

    it 'find item metadata' do
      expect(resource).to have_action(:metadata).that_handles(200).at_path('/rest/items/:id/metadata').with_verb(:get) do |handled|
        expect(handled).to all(be_kind_of(Dspace::Metadata))
      end
    end

    it 'add item metadata' do
      expect(resource).to have_action(:add_metadata).that_handles(200).at_path('/rest/items/:id/metadata').with_verb(:post) do |handled|
        expect(handled).to aeq(true)
      end
    end

    it 'add item bitstreams' do
      expect(resource).to have_action(:add_bitstream).that_handles(200, 201).at_path('/rest/items/:id/bitstreams').with_verb(:post) do |handled|
        expect(handled).to eq(true)
      end
    end
    
    it 'find item bitstream' do
      expect(resource).to have_action(:bitstreams).that_handles(200).at_path('/rest/items/:id/bitstreams').with_verb(:get) do |handled|
        expect(handled).to all(be_kind_of(Dspace::Bitstream))
      end
    end

    it 'clear item metadata' do
      expect(resource).to have_action(:clear_metadata).that_handles(200, 201, 204).at_path('/rest/items/:id/metadata').with_verb(:delete) do |handled|
        expect(handled).to eq(true)
      end
    end

    it 'Delete item bitstream' do
      expect(resource).to have_action(:delete_bitstream).that_handles(200, 201, 204).at_path('/rest/items/:id/bitstreams/:bitstream_id').with_verb(:delete) do |handled|
        expect(handled).to eq(true)
      end
    end

  end
end