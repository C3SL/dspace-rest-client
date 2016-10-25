# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dspace/version'

Gem::Specification.new do |spec|
  spec.date = '2016-09-27'
  spec.name = 'dspace_rest_client'
  spec.version = Dspace::VERSION
  spec.authors = ['Mauricio Giacomini Girardello', 'Lucas Ernesto Kindinger', 'Bruno N. Zanette', 'Mateus Rambo Strey']
  spec.email = ['mauriciogiacomini4@gmail.com', 'mateus.rstrey@gmail.com' 'kindingerlek@hotmail.com']
  spec.summary = 'DSpace REST API Client for Ruby'
  spec.description = 'DSpace REST-API Client for Ruby! Implements all DSpace REST-API endpoints requests.'
  spec.homepage = 'https://gitlab.c3sl.ufpr.br/c3sl/dspace-rest-client'
  spec.license = 'GNU - General Public License'
  spec.test_files = `git ls-files -z spec/`.split("\0")
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'
  spec.add_runtime_dependency 'resource_kit', '>= 0.1.4'
  spec.add_runtime_dependency 'faraday', '~> 0.9.2'
  spec.add_runtime_dependency 'net-http-persistent', '~> 2.9', '>= 2.9.4'
  spec.add_runtime_dependency 'activesupport', '>= 4.2.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
end
