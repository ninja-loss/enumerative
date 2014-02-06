# -*- encoding: utf-8 -*-
require File.expand_path('../lib/enumerative/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nils Jonsson", "C. Jason Harrelson"]
  gem.email         = ["ninja.loss@gmail.com"]
  gem.description   = %q{Tools for defining and using enumerations.}
  gem.summary       = %q{Tools for enumerations.}
  gem.homepage      = "https://github.com/ninja-loss/enumerative"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "enumerative"
  gem.require_paths = ["lib"]
  gem.version       = Enumerative::VERSION

  gem.add_dependency "activesupport"
end
