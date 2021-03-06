# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-event_store-http-connect'
  s.version = '0.1.0.0'
  s.summary = "Connection library to EventStore's HTTP interface"
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/event-store-http-connect'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-dns-resolve_host'

  s.add_development_dependency 'test_bench'
end
