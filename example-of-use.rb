require_relative 'lib/dspace_rest_client'
require 'json'

client = DspaceClient.new('https://demo.dspace.org/rest')

puts '#### status ####'
puts client.status
client.login 'dspacedemo+admin@gmail.com', 'dspace'

puts '#### after login ####'
puts client.status

puts '#### counting communities ####'
community_repository = client.repository.community_repository
all_communities = community_repository.get_all_communities

i = 0
all_communities.each do
  i += 1
end

puts "dspace have #{i} communities"

puts '#### get all items by limit/offset ####'
item_repository = client.repository.item_repository

limit = 5
offset = 0

all_items = item_repository.get_all_items('',limit,offset)
while !all_items.nil?
  puts "LIMIT: #{limit} / OFFSET: #{offset}"
  all_items.each do |i|
    puts i.name
  end
  offset = offset + limit
  all_items = item_repository.get_all_items('',limit,offset)
end
