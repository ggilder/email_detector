# -*- encoding: utf-8 -*-
require File.expand_path('../lib/email_detector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gabriel Gilder"]
  gem.email         = ["gabriel@gabrielgilder.com"]
  gem.description   = %q{EmailDetector detects email addresses in an input string.}
  gem.summary       = %q{EmailDetector detects email addresses in an input string.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "email_detector"
  gem.require_paths = ["lib"]
  gem.version       = EmailDetector::VERSION
  gem.add_development_dependency 'rspec', '~>2'
  gem.add_development_dependency 'simplecov'
end
