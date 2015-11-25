require_relative 'lib/dspace'
require 'faraday'

faraday = Faraday.new('https://mecdb3.c3sl.ufpr.br:8443/rest', {ssl: {verify: false}, headers: {content_type: 'application/json',
                                                                                                accept: 'application/json'}})
r = Dspace::Resources::CommunityResource.new(connection: faraday)
p r.all