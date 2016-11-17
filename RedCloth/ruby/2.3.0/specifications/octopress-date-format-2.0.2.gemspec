# -*- encoding: utf-8 -*-
# stub: octopress-date-format 2.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "octopress-date-format"
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brandon Mathis"]
  s.date = "2014-10-23"
  s.description = "Adds nicely formated dates to Jekyll posts and pages. (formerly: 'jekyll-date-format')"
  s.email = ["brandon@imathis.com"]
  s.homepage = "https://github.com/octopress/date-format"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Adds nicely formated dates to Jekyll posts and pages. (formerly: 'jekyll-date-format')"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<octopress-hooks>, ["~> 2.0"])
      s.add_runtime_dependency(%q<jekyll>, ["~> 2.0"])
      s.add_development_dependency(%q<clash>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>, [">= 0"])
    else
      s.add_dependency(%q<octopress-hooks>, ["~> 2.0"])
      s.add_dependency(%q<jekyll>, ["~> 2.0"])
      s.add_dependency(%q<clash>, ["~> 1.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<pry-byebug>, [">= 0"])
    end
  else
    s.add_dependency(%q<octopress-hooks>, ["~> 2.0"])
    s.add_dependency(%q<jekyll>, ["~> 2.0"])
    s.add_dependency(%q<clash>, ["~> 1.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<pry-byebug>, [">= 0"])
  end
end
