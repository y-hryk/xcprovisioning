# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcprovisioning/version'

Gem::Specification.new do |spec|
  spec.name          = "xcprovisioning"
  spec.version       = Xcprovisioning::VERSION
  spec.authors       = ["y-hryk"]
  spec.email         = ["dev.hy630823@gmail.com"]

  spec.summary       = "Manage the provision profile"

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor"
  spec.add_dependency "terminal-table"
  spec.add_dependency "plist"

end