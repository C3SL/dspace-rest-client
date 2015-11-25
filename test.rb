require "resource_kit"
require "dspace/version"
require "dspace/resources/community_resource"

conn = Faraday.new(url:'https://demo.dspace.org/rest')

resource = Dspace::Resources::CommunityResource.new(connection: conn)
p resource.all