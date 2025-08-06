# -*- encoding: utf-8 -*-
# stub: fog-joyent 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fog-joyent".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["The Effeminate Batman".freeze]
  s.date = "2017-04-07"
  s.description = "Module for the 'fog' gem to support Joyent.".freeze
  s.email = "eb@frosthawk.com".freeze
  s.homepage = "https://github.com/fog/fog-joyent".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.19".freeze
  s.summary = "This library can be used as a module for 'fog'.".freeze

  s.installed_by_version = "3.4.19" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<fog-core>.freeze, ["~> 1.42"])
  s.add_runtime_dependency(%q<fog-json>.freeze, [">= 1.0"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  s.add_development_dependency(%q<shindo>.freeze, ["~> 0.3"])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.34"])
end
