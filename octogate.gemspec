# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octogate/version'

Gem::Specification.new do |spec|
  spec.name          = "octogate"
  spec.version       = Octogate::VERSION
  spec.authors       = ["joker1007"]
  spec.email         = ["kakyoin.hierophant@gmail.com"]
  spec.summary       = %q{Github webhook proxy server}
  spec.description   = %q{Github webhook proxy server. Request target is defined by Ruby DSL}
  spec.homepage      = "https://github.com/joker1007/octogate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "activesupport", ">= 4"
  spec.add_runtime_dependency "oj"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "hashie"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "tapp"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "thin"
end
