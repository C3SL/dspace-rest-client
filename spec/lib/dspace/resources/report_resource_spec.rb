require 'spec_helper'

RSpec.describe Dspace::Resources::ReportResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::ReportResource }

  it 'get list of use case filters' do
    expect(resource).to have_action(:filters).that_handles(200).at_path('/rest/filters').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::ItemFilter))
    end
  end

  it 'get filtered collections' do
    expect(resource).to have_action(:filtered_collections).that_handles(200).at_path('/rest/filtered-collections').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Collection))
    end
  end

  it 'get filtered collections by id' do
    expect(resource).to have_action(:filtered_collections_by_id).that_handles(200).at_path('/rest/filtered-collections/:collection_id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Collection)
    end
  end

  it 'get filtered items' do
    expect(resource).to have_action(:filtered_items).that_handles(200).at_path('/rest/filtered-items').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Item))
    end
  end

end
