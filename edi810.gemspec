# frozen_string_literal: true

require_relative "lib/edi810/version"

Gem::Specification.new do |spec|
  spec.name          = "edi810"
  spec.version       = Edi810::VERSION
  spec.authors       = ["edi810 contributors"]
  spec.summary       = "Ruby parser, generator, and validator for ANSI X12 EDI 810 Invoice transaction sets"
  spec.description   = "A zero-dependency Ruby library for parsing, generating, and validating " \
                        "ANSI X12 EDI 810 Invoice documents. Supports all segments from the specification " \
                        "with auto-detection of delimiters, structural validation, and round-trip fidelity."
  spec.homepage      = "https://github.com/edi810/edi810"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.files         = Dir["lib/**/*.rb", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.add_development_dependency "rake",  "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "pry"
end
