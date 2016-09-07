# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workable_json_assertions/version'

Gem::Specification.new do |spec|
  spec.name          = 'workable_json_assertions'
  spec.version       = WorkableJsonAssertions::VERSION
  spec.authors       = ['Angelos Karagkiozidis']
  spec.email         = ['angelkar@gmail.com']
  spec.description   = ''
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency "actionpack", ">= 4.2"
  spec.add_dependency "actionview", ">= 4.2"
  spec.add_development_dependency "railties", "> 4.2"
  spec.add_development_dependency "minitest", "> 5.0"
end
