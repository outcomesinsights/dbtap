# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbtap/version'

Gem::Specification.new do |spec|
  spec.name          = "dbtap"
  spec.version       = Dbtap::VERSION
  spec.authors       = ["Ryan Duryea"]
  spec.email         = ["aguynamedryan@gmail.com"]
  spec.summary       = %q{Write database-agnostic, TAP-emitting unit tests for your database}
  spec.description   = %q{A database-agnostic reimplementation of my favorite methods from pgTAP}
  spec.homepage      = "https://github.com/outcomesinsights/dbtap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'sequelizer', '~> 0.0', '>= 0.0.3'
end
