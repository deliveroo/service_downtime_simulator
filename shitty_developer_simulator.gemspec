lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shitty_developer_simulator'

Gem::Specification.new do |spec|
  spec.name          = 'shitty_developer_simulator'
  spec.version       = ShittyDeveloperSimulator::VERSION
  spec.authors       = ['Josh McMillan']
  spec.email         = ['josh@joshmcmillan.co.uk']

  spec.summary       = "Want to know what it's like to have me in your dev team? This gem is for you!"
  spec.homepage      = 'https://github.com/mcmillan/shitty_developer_simulator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
