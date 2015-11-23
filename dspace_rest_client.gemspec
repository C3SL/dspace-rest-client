# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dspace/version'

Gem::Specification.new do |spec|
  spec.date = '2015-11-23'
  spec.name = "dspace_rest_client"
  spec.version = Dspace::VERSION
  spec.authors = ["Mauricio Giacomini Girardello", "Lucas Ernesto Kindinger", "Bruno N. Zanette", "Mateus Rambo Strey"]
  spec.email = ["mauriciogiacomini4@gmail.com", "kindingerlek@hotmail.com"]

  spec.summary = 'DSpace REST API Client for Ruby'
  spec.description = 'DSpace REST-API Client for Ruby! Implements all DSpace REST-API endpoints requests.'
  spec.homepage = 'https://gitlab.c3sl.ufpr.br/c3sl/dspace-rest-client'
  spec.license = 'GNU - General Public License'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.test_files = `git ls-files -z test/`.split("\0")
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
