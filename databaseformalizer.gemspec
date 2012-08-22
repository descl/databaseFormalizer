# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
Gem::Specification.new do |s|
  s.name = %q{databaseformalizer}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christophe Desclaux"]
  s.date = %q{2012-05-01}
  s.email = %q{descl@zouig.org}

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a gem for generating databases interaction controllers}
  
  s.add_dependency('ruby-graphviz', '~> 1.0.5')
  s.add_dependency('jquery-rails', "~> 1.0.19")
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end