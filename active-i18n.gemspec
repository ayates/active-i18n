$: << File.expand_path('../lib', __FILE__)

require 'active_i18n/version'

Gem::Specification.new do |s|
  s.name         = 'active-i18n'
  s.version      = ActiveI18n::VERSION
  s.authors      = ['Andrew Yates']
  s.email        = 'me@andre.ws'
  s.homepage     = 'http://andre.ws'
  s.summary      = 'Provides quick and easy model translations'
  s.description  = 'Provides quick and easy model translations'
  s.files        = Dir['{lib/**/*,[A-Z]*}']
  s.require_path = 'lib'

  s.add_dependency 'activerecord', '~> 3.2.0'
end