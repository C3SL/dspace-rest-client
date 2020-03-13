require 'spec_helper'

RSpec.describe Dspace::Resources::SchemaRegistryResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::SchemaRegistryResource }

  it 'get all schemas' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/registries/schema').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Schema))
    end
  end

  it 'find schema' do
    expect(resource).to have_action(:find_schema).that_handles(200).at_path('/rest/registries/schema/:schema_prefix').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Schema)
    end
  end

  it 'create a new schema' do
    expect(resource).to have_action(:create_schema).that_handles(200).at_path('/rest/registries/schema').with_verb(:post) do |handled|
      expect(handled).to be_kind_of(Dspace::Schema)
    end
  end

  it 'delete schema' do
    expect(resource).to have_action(:delete_schema).that_handles(200).at_path('/rest/registries/schema/:schema_id').with_verb(:delete) do |handled|
      expect(handled).to eq(true)
    end
  end

  it 'find metadata-field by id' do
    expect(resource).to have_action(:find_metadata_field).that_handles(200).at_path('/rest/registries/metadata-fields/:field_id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::MetadataField)
    end
  end

  it 'update a metadata-field' do
    expect(resource).to have_action(:update_metadata_field).that_handles(200).at_path('/rest/registries/metadata-fields/:field_id').with_verb(:put) do |handled|
      expect(handled).to eq(true)
    end
  end

  it 'delete metadata-field' do
    expect(resource).to have_action(:delete_metadata_field).that_handles(200).at_path('/rest/registries/metadata-fields/:field_id').with_verb(:delete) do |handled|
      expect(handled).to eq(true)
    end
  end

  context "with schema scope" do

    it 'create a new metadata field' do
      expect(resource).to have_action(:create_metadata_field).that_handles(200).at_path('/rest/registries/schema/:schema_prefix/metadata-fields').with_verb(:post) do |handled|
        expect(handled).to be_kind_of(Dspace::MetadataField)
      end
    end

    it 'find unqualified-element by element' do
      expect(resource).to have_action(:find_unqualified_element).that_handles(200).at_path('/rest/registries/schema/:schema_prefix/metadata-fields/:element').with_verb(:get) do |handled|
        expect(handled).to be_kind_of(Dspace::MetadataField)
      end
    end

    it 'find qualified-element by element and qualifier' do
      expect(resource).to have_action(:find_qualified_element).that_handles(200).at_path('/rest/registries/schema/:schema_prefix/metadata-fields/:element/:qualifier').with_verb(:get) do |handled|
        expect(handled).to be_kind_of(Dspace::MetadataField)
      end
    end

  end
end
