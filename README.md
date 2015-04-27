# DSpace REST Client

DSpace REST Client is a ruby gem that integrates DSpace servers with your application.
For now, the gem is under development, so some features are missing.

## Example of use:

Login

```ruby
require 'dspace-rest-client'

client = DspaceClient.new('https://demo.dspace.org/rest')
client.login 'dspacedemo+admin@gmail.com', 'dspace'

# check the status after authentication
puts client.status
```

List communities

```ruby
require 'dspace-rest-client'

client = DspaceClient.new('https://demo.dspace.org/rest')
community_repository = client.repository.community_repository
all_communities = community_repository.get_all_communities

all_communities.each do |c|
    puts c.name
end
```

#### Bitstreams features:
- √ GET /bitstreams - Return all bitstreams in DSpace.
- √ GET /bitstreams/{bitstream id} - Return bitstream.
- GET /bitstreams/{bitstream id}/policy - Return bitstream policies.
- √ GET /bitstreams/{bitstream id}/retrieve - Return data of bitstream.
- POST /bitstreams/{bitstream id}/policy - Add policy to item. You must post a ResourcePolicy
- PUT /bitstreams/{bitstream id}/data - Update data/file of bitstream. You must put the data
- √ PUT /bitstreams/{bitstream id} - Update metadata of bitstream. You must put a Bitstream, does not alter the file/data
- DELETE /bitstreams/{bitstream id} - Delete bitstream from DSpace.
- DELETE /bitstreams/{bitstream id}/policy/{policy_id} - Delete bitstream policy.

#### Collections features:
- √ GET /communities/{communityId}/collections - Returns array of collections of community.
- √ GET /collections - Return all collections of DSpace in array.
- √ GET /collections/{collectionId} - Return collection with id.
- √ GET /collections/{collectionId}/items - Return all items of collection.
- √ POST /communities/{communityId}/collections - Create new collections in community. You must post Collection.
- √ POST /collections/{collectionId}/items - Create posted item in collection. You must post an Item
- POST /collections/find-collection - Find collection by passed name.
- PUT /collections/{collectionId} - Update collection. You must put Collection.
- DELETE /collections/{collectionId} - Delete collection from DSpace.
- DELETE /collections/{collectionId}/items/{itemId} - Delete item in collection.
- DELETE /communities/{communityId}/collections/{collectionId} - Delete collection in community.

#### Community features:
- √ GET /communities - Returns array of all communities in DSpace.
- √ GET /communities/top-communities - Returns array of all top communities in DSpace
- √ GET /communities/{communityId} - Returns community
- √ GET /communities/{communityId}/communities - Returns array of subcommunities of community.
- √ POST /communities - Create new community at top level. You must post community.
- √ POST /communities/{communityId}/communities - Create new subcommunity in community. You must post Community.
- PUT /communities/{communityId} - Update community. You must put Community
- DELETE /communities/{communityId} - Delete community.
- DELETE /communities/{communityId}/communities/{communityId2} - Delete subcommunity in community.

#### Item features:
- √ GET /items - Return list of items.
- √ GET /items/{item id} - Return item.
- √ GET /items/{item id}/metadata - Return item metadata.
- √ GET /items/{item id}/bitstreams - Return item bitstreams.
- POST /items/find-by-metadata-field - Find items by metadata entry. You must post a MetadataEntry.  DS-2501 - wrong SQL in REST /items/find-by-metadata-field CLOSED
- √ POST /items/{item id}/metadata - Add metadata to item. You must post an array of MetadataEntry
- √ POST /items/{item id}/bitstreams - Add bitstream to item. You must post a Bitstream
- √ PUT /items/{item id}/metadata - Update metadata in item. You must put a MetadataEntry
- √ DELETE /items/{item id} - Delete item.
- DELETE /items/{item id}/metadata - Clear item metadata.
- DELETE /items/{item id}/bitstreams/{bitstream id} - Delete item bitstream.

### Version
1.0.0

### Contributors
> - Mauricio Giacomini Girardello <mgg12@inf.ufpr.br>
> - Bruno Zanette <>

### Installation

You need compile the gem:
```sh
$ gem build dspace-rest-client.gemspec
```

To install:
```sh
gem install --local dspace-rest-client-1.0.0.gem
```

### Development
Want to contribute? Great!
...

License
----
MIT


**Free Software, Hell Yeah!**