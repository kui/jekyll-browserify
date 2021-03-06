# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/browserify/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-browserify"
  spec.version       = Jekyll::Browserify::VERSION
  spec.authors       = ["Keiichiro Ui"]
  spec.email         = ["keiichiro.ui@gmail.com"]

  spec.summary       = %q{A browserify converter for Jekyll}
  spec.homepage      = "https://github.com/kui/jekyll-browserify"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "browserify_rb", "~> 1.0.0"

  spec.add_development_dependency "jekyll", ENV['JEKYLL_VERSION'] ? "~> #{ENV['JEKYLL_VERSION']}" : ">= 2.0"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
