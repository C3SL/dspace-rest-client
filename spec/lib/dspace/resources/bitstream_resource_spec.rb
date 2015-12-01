require 'spec_helper'

RSpec.describe Dspace::Resources::BitstreamResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::BitstreamResource }

  it 'get all bitstreams' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/bitstreams').with_verb(:get) do |handled|
      expect(handled).to all(be_kind_of(Dspace::Bitstream))
    end
  end

  it 'find bitstream by id' do
    expect(resource).to have_action(:find).that_handles(200).at_path('/rest/bitstreams/:id').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Bitstream)
    end
  end

  it 'Delete bitstream' do
    expect(resource).to have_action(:delete).that_handles(200).at_path('/rest/bitstreams/:id').with_verb(:delete) do |handled|
      expect(handled).to eq(true)
    end
  end

  it 'retrive bitstream' do
    expect(resource).to have_action(:retrieve).that_handles(200).at_path('/rest/bitstreams/:id/retrieve').with_verb(:get)

    #TODO: mock actions expectations for test if retrieve method returns a Tempfile
  end

  context 'Bitstream scope' do

    it 'find bitstream policy' do
      expect(resource).to have_action(:policy).that_handles(200).at_path('/rest/bitstreams/:id/policy').with_verb(:get) do |handled|
        expect(handled).to be_kind_of(Dspace::Policy)
      end
    end

    it 'delete bitstream policy' do
      expect(resource).to have_action(:delete_policy).that_handles(200, 201, 204).at_path('/rest/bitstreams/:id/policy/:policy_id').with_verb(:delete) do |handled|
        expect(handled).to eq(true)
      end
    end

  end
end