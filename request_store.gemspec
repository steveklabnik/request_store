# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'request_store/version'

Gem::Specification.new do |gem|
  gem.name          = "request_store"
  gem.version       = RequestStore::VERSION
  gem.authors       = ["Steve Klabnik"]
  gem.email         = ["steve@steveklabnik.com"]
  gem.description   = %q{RequestStore gives you per-request global storage.}
  gem.summary       = %q{RequestStore gives you per-request global storage.}
  gem.homepage      = "http://github.com/steveklabnik/request_store"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency 'minitest', '~> 3.0'
end
