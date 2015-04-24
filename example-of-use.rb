require File.dirname(__FILE__) + '/lib/dspace-rest-client'
require 'json'

client = DspaceClient.new('https://demo.dspace.org/rest')

puts '#### status #### '
puts client.status
client.login 'dspacedemo+admin@gmail.com', 'dspace'

puts '#### after login ###'
puts client.status

puts '#### counting communities'
community_repository = client.repository.community_repository
all_communities = community_repository.get_all_communities

i = 0
all_communities.each do
  i += 1
end

puts "dspace have #{i} communities"