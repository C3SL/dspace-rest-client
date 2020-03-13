# DSpace REST Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dspace_rest_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dspace_rest_client

## DSpace Version

The `master` branch is currently on version 3.x.x, which only works with DSpace 6.

If you're using DSpace 5 you will need to use the branch `v2.x.x`.

## Resources

### Item's resources
* action :all, 'GET /rest/items' (query_keys :expand, :limit, :offset)
* action :find, 'GET /rest/items/:id' (query_keys :expand)
* action :find_by_metadata, 'POST /rest/items/find-by-metadata-field'
* action :metadata, 'GET /rest/items/:id/metadata'
* action :bitstreams, 'GET /rest/items/:id/bitstreams' (query_keys :expand, :limit, :offset)
* action :delete, 'DELETE /rest/items/:id'
* action :clear_metadata, 'DELETE /rest/items/:id/metadata'
* action :delete_bitstream, 'DELETE /rest/items/:id/bitstreams/:bitstream_id'
* action :add_metadata, 'POST /rest/items/:id/metadata'
* action :add_bitstream, 'POST /rest/items/:id/bitstreams' (query_keys :name, :description, :bundle_name)
* action :update_metadata, 'PUT /rest/items/:id/metadata'

### Collection's resources
* action :all, 'GET /rest/collections' (query_keys :expand, :limit, :offset)
* action :find, 'GET /rest/collections/:id' (query_keys :expand)
* action :update, 'PUT /rest/collections/:id'
* action :delete, 'DELETE /rest/collections/:id'
* action :delete_item, 'DELETE /rest/collections/:id/items/:item_id'
* action :items, 'GET /rest/collections/:id/items' (query_keys :expand, :limit, :offset)
* action :create_item, 'POST /rest/collections/:id/items'

### Community's resources
* action :all, 'GET /rest/communities' (query_keys :expand, :limit, :offset)
* action :top_communities, 'GET /rest/communities/top-communities' (query_keys :expand, :limit, :offset)
* action :find, 'GET /rest/communities/:id' (query_keys :expand)
* action :collections, 'GET /rest/communities/:id/collections' (query_keys :expand, :limit, :offset)
* action :sub_communities, 'GET /rest/communities/:id/communities' (query_keys :expand, :limit, :offset)
* action :create, 'POST /rest/communities'
* action :create_subcommunity, 'POST /rest/communities/:id/communities'
* action :create_collection, 'POST /rest/communities/:id/collections'
* action :update, 'PUT /rest/communities/:id'
* action :delete, 'DELETE /rest/communities/:id'
* action :delete_collection, 'DELETE /rest/communities/:id/collections/:collection_id'
* action :delete_subcommunity, 'DELETE /rest/communities/:id/communities/:subcommunity_id'

### Bitstream's resources
* action :all, 'GET /rest/bitstreams' (query_keys :expand, :limit, :offset)
* action :find, 'GET /rest/bitstreams/:id' (query_keys :expand)
* action :policy, 'GET /rest/bitstreams/:id/policy'
* action :retrieve, 'GET /rest/bitstreams/:id/retrieve'
* action :delete, 'DELETE /rest/bitstreams/:id'
* action :delete_policy, 'DELETE /rest/bitstreams/:id/policy/:policy_id'
* action :add_policy, 'POST /rest/bitstreams/:id/policy'
* action :update, 'PUT /rest/bitstreams/:id'}
* action :update_data, 'PUT /rest/bitstreams/:id/data' do

### Authentication's resources
* action :login, 'POST /rest/login'
* action :logout, 'POST /rest/logout'

### Status's resources
* action :test, 'GET /rest/test'
* action :status, 'GET /rest/status'

## Get started

Some requests requires user authentication.

```ruby
require 'dspace'
client = Dspace::Client.new(dspace_api: 'https://demo.dspace.org/')

if !client.is_running?
  raise 'Can\'t connect to DSpace API.'
end

# authenticate
client.login 'dspacedemo+admin@gmail.com', 'dspace'

# create an community
client.communities.create(Dspace::Community.new({'name' => 'Testando'}))

# get a bitstream and your file
bitstream = client.bitstreams.find(id: 20, expand: 'parent')
tmp_file = client.bitstreams.retrieve(id: 20) #<Tempfile:/tmp/..._teste.jpg>

# creating a new bitstream for some item
file = File.new('/your/path/Pictures/Celular/some_book.pdf', 'r')
bitstream = client.items.add_bitstream(file, id: 11, name: 'some_book.pdf', description: 'testing upload a pdf book')

# updating bitstream metadata
bitstream.name = 'new_book_name.pdf'
client.bitstreams.update(bitstream, id: bitstream.id)
```

To see more examples, visit our Wiki.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration.
