# -*- encoding: utf-8 -*-
# stub: hocon 1.2.5 ruby lib

Gem::Specification.new do |s|
  s.name = "hocon".freeze
  s.version = "1.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Price".freeze, "Wayne Warren".freeze, "Preben Ingvaldsen".freeze, "Joe Pinsonault".freeze, "Kevin Corcoran".freeze, "Jane Lu".freeze]
  s.date = "2016-10-27"
  s.description = "== A port of the Java {Typesafe Config}[https://github.com/typesafehub/config] library to Ruby".freeze
  s.email = "chris@puppetlabs.com".freeze
  s.executables = ["hocon".freeze]
  s.files = ["bin/hocon".freeze]
  s.homepage = "https://github.com/puppetlabs/ruby-hocon".freeze
  s.licenses = ["Apache License, v2".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.0".freeze)
  s.rubygems_version = "2.7.6.1".freeze
  s.summary = "HOCON Config Library".freeze

  s.installed_by_version = "2.7.6.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.14"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.14"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.14"])
  end
end
