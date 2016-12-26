lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'music/version'

Gem::Specification.new do |s|
  s.name        = 'music-ruby'
  s.version     = Music.version
  s.date        = '2014-10-27'
  s.summary     = "Useful tools to deal with music notation"
  s.description = "Useful tools to deal with music notation using Ruby"
  s.authors     = ["Tom ten Thij"]
  s.email       = 'mail@tomtenthij.nl'
  s.files       = `git ls-files`.split($/)
  s.homepage    = ""
  s.license     = 'MIT'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
end
