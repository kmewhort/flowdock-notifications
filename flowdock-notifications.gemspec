# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flowdock-notifications/version'

Gem::Specification.new do |spec|
  spec.name          = "flowdock-notifications"
  spec.version       = FlowdockNotifications::VERSION
  spec.authors       = ["Kent Mewhort"]
  spec.email         = ["kent@openissues.ca"]

  spec.summary       = %q{Cross-platform desktop notifications for Flowdock}
  spec.homepage      = "http://github.com/kmewhort/flowdock-notifications"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.executables << 'flowdock-notifications'

  spec.add_runtime_dependency "flowdock"
  spec.add_runtime_dependency "notify"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
