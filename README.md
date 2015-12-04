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