require_relative 'lib/dspace'
require 'faraday'

faraday = Faraday.new('https://demo.dspace.org/', {ssl: {verify: false}, headers: {content_type: 'application/json',
                                                                                   accept: 'application/json'}})

r = Dspace::Resources::AuthenticationResource.new(connection: faraday)