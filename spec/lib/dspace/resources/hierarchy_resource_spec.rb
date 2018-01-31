require 'spec_helper'

RSpec.describe Dspace::Resources::HierarchyResource, resource_kit: true do
  subject(:resource) { Dspace::Resources::HierarchyResource }

  it 'get all hierarchy' do
    expect(resource).to have_action(:all).that_handles(200).at_path('/rest/hierarchy').with_verb(:get) do |handled|
      expect(handled).to be_kind_of(Dspace::Site)
    end
  end

end
