Gem::Specification.new do |s|
  s.name = 'dspace_rest_client'
  s.version = '1.1.2'
  s.date = '2015-05-22'
  s.summary = "DSpace REST-API Client for Ruby!"
  s.description = "DSpace REST-API Client for Ruby! Implements all DSpace REST-API endpoints requests."
  s.authors = ["Mauricio Giacomini Girardello", "Bruno N. Zanette", "Mateus Rambo Strey"]
  s.email = 'c3sl@c3sl.ufpr.br'
  s.files = Dir['lib/*.rb'] +
      Dir['lib/dspacerest/*.rb'] +
      Dir['lib/dspacerest/repositories/*.rb'] +
      Dir['lib/dspacerest/builders/*.rb'] +
      Dir['lib/dspacerest/strategies/uploads/*.rb'] +
      Dir['bin/*']
  #s.files       = `git ls-files -z`.split("\0")
  #s.test_files  = `git ls-files -z spec/`.split("\0")
  s.homepage = 'https://gitlab.c3sl.ufpr.br/c3sl/dspace-rest-client'
  s.license = 'GNU General Public License'

  s.add_dependency('rest-client', '>= 1.7', '< 2')
  s.add_dependency('curb', '~> 0.8.6')
end
