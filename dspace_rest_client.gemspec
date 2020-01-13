# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dspace/version'

Gem::Specification.new do |spec|
  spec.date = '2020-01-13'
  spec.name = 'dspace_rest_client'
  spec.version = Dspace::VERSION
  spec.authors = ['Mauricio Giacomini Girardello', 'Bruno Nocera Zanette', 'Mateus Rambo Strey']
  spec.email = ['mauriciogiacomini4@gmail.com', 'brunonzanette@gmail.com', 'mateus.rstrey@gmail.com']
  spec.summary = 'DSpace REST API Client for Ruby'
  spec.description = 'DSpace REST-API Client for Ruby! Implements all DSpace REST-API endpoints requests.'
  spec.homepage = 'https://github.com/BrunoNZ/dspace-rest-client'
  spec.license = 'GNU - General Public License'
  spec.test_files = `git ls-files -z spec/`.split("\0")
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json', '~> 2.3'
  spec.add_runtime_dependency 'resource_kit', '~> 0.1.7'
  spec.add_runtime_dependency 'faraday', '~> 1.0'
  spec.add_runtime_dependency 'net-http-persistent', '~> 3.1'
  spec.add_runtime_dependency 'activesupport', '~> 6.0', '>= 6.0.2.1'

  spec.add_development_dependency 'bundler', '~> 2.1', '>= 2.1.4'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9'
end
