# frozen_string_literal: true

require_relative 'lib/weasyl'
Gem::Specification.new do |s|
  s.name        = Weasyl::NAME
  s.version     = Weasyl::VERSION
  s.date        = Time.now.strftime('%F')
  s.summary     = 'Ruby bindings for weasyl'
  s.description = 'Ruby bindings for the weasyl art board'
  s.author      = 'Maxine Michalski'
  s.email       = 'maxine@furfind.net'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/maxine-red/weasyl'
  s.license     = 'GPL-3.0'
  s.required_ruby_version = '~> 2.3'
  s.add_runtime_dependency 'json', '~> 2.0'
end
