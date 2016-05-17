# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "easy_graph/version"

Gem::Specification.new do |spec|
  spec.name          = "easy_graph"
  spec.version       = EasyGraph::VERSION
  spec.authors       = ["Julian Rogmans"]
  spec.email         = ["rogmansj@gmail.com"]

  spec.summary       = %q{Write a short summary, because Rubygems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/julianrogmans/easy_graph/branches/yours"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "4.2.6"
  spec.add_dependency "graphql"
  spec.add_dependency "inflections"
  spec.add_development_dependency "require_all"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
