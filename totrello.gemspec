# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'totrello/version'

Gem::Specification.new do |spec|
  spec.name          = "totrello"
  spec.version       = Totrello::VERSION
  spec.authors       = "Josh Teeter"
  spec.email         = "joshteeter@gmail.com"
  spec.summary       = "Turns todo items into trello cards."
  spec.description   = "This will take the todo items in your code and turn them into trello cards"
  spec.homepage      = "https://github.com/whatisinternet/ToTrello"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.0'

  spec.add_dependency 'ruby-trello', '~> 1.1.1'

end

