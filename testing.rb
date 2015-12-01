require_relative 'lib/dspace'

client = Dspace::Client.new(dspace_api: 'https://demo.dspace.org/')

#if !client.is_running?
#  raise 'Can\'t connect to DSpace API.'
#end

client.login 'dspacedemo+admin@gmail.com', 'dspace'

my_bitstream = client.bitstreams.find(id: 47)
my_bitstream.name = 'update_bitstream.jpg'
client.bitstreams.update(my_bitstream, id: 47)

#faraday = client.connection
#file = File.new('/Users/mauriciogirardello/Pictures/Celular/IMG_20130616_171009.jpg', 'r')
#p client.items.add_bitstream(file, id: 11, name: 'nova_foto.jpg', description: 'testando upload')
#p faraday.post '/rest/items/11/bitstreams?name=foto.jpg', Base64.encode64(file.read) do |r|
#  r.headers['Content-Type'] = 'image/jpeg'
#end



#UploadIO.new("file.txt", "text/plain")

#file_io = File.open('/Users/mauriciogirardello/Workspace/c3sl/dspace-rest-client/README.md')
#file = UploadIO.new(file_io, "text/plain", "file.txt")

#p client.items.add_bitstream UploadIO.new("/Users/mauriciogirardello/Workspace/c3sl/dspace-rest-client/README.md", "text/plain"), id: 4, name: 'README.md'