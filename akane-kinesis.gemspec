# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'akane/kinesis/version'

Gem::Specification.new do |spec|
  spec.name          = "akane-kinesis"
  spec.version       = Akane::Kinesis::VERSION
  spec.authors       = ["Yoshiori SHOJI"]
  spec.email         = ["yoshiori@gmail.com"]
  spec.summary       = %q{storage plugin for akane that post to Amazon Kinesis.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/yoshiori/akane-kinesis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "akane"
  spec.add_dependency "aws-sdk"
end
