# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ascii_table_value_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "ascii_table_value_parser"
  spec.version       = AsciiTableValueParser::VERSION
  spec.authors       = ["Derek Bender"]
  spec.email         = ["nofeardjb@gmail.com"]
  spec.summary       = "Parse Ascii Tables Values"
  spec.description   = "Parse Ascii Tables Values."
  spec.homepage      = "https://github.com/djbender/ascii_table_value_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
