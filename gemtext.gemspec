require_relative 'lib/gemtext/version'

Gem::Specification.new do |spec|
  spec.name          = "gemtext"
  spec.version       = Gemtext::VERSION
  spec.authors       = ["Exa Stencil"]
  spec.email         = ["git@exastencil.com"]

  spec.summary       = %q{Gemtext parser for Ruby}
  spec.description   = %q{Produces a Gemtext::Document of Gemtext::Nodes from a Ruby IO}
  spec.homepage      = "https://github.com/exastencil/gemtext"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/exastencil/gemtext"
  spec.metadata["changelog_uri"] = "https://github.com/exastencil/gemtext/blob/main/CHANGELOG.md"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
