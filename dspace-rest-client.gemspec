Gem::Specification.new do |s|
  s.name        = 'dspace-rest-client'
  s.version     = '0.0.1'
  s.date        = '2015-01-20'
  s.summary     = "DSpace REST-API Client for Ruby!"
  s.description = "DSpace REST-API Client for Ruby!"
  s.authors     = ["C3SL - Centro de Computação Cientifica e Software Livre"]
  s.email       = 'c3sl@c3sl.ufpr.br'
  s.files       = `git ls-files -z`.split("\0")
  #s.test_files  = `git ls-files -z spec/`.split("\0")
  s.homepage    = 'https://gitlab.c3sl.ufpr.br/bnzanette/dspace-rest-client'
  s.license     = 'GNU General Public License'

  s.add_development_dependency('rest-client')
end
