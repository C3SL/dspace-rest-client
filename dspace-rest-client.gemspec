Gem::Specification.new do |s|
  s.name        = 'dspace-rest-client'
  s.version     = '0.0.1'
  s.date        = '2015-01-20'
  s.summary     = "DSpace REST-API Client for Ruby!"
  s.description = "DSpace REST-API Client for Ruby! Implements all DSpace REST-API endpoints requests."
  s.authors     = ["C3SL - Centro de Computação Cientifica e Software Livre"]
  s.email       = 'c3sl@c3sl.ufpr.br'
  s.files       = Dir['lib/*.rb'] +
                  Dir['lib/dspacerest/*.rb'] +
                  Dir['bin/*']
  #s.files       = `git ls-files -z`.split("\0")
  #s.test_files  = `git ls-files -z spec/`.split("\0")
  s.homepage    = 'https://gitlab.c3sl.ufpr.br/bnzanette/dspace-rest-client'
  s.license     = 'GNU General Public License'

  s.add_dependency('rest-client', '>= 1.7', '< 2')
  s.add_dependency('curb', '~> 0.8.6')
end
