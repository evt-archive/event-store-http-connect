ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'event_store/http/connect/controls'

require 'test_bench'; TestBench.activate

require 'pp'

Controls = EventStore::HTTP::Connect::Controls

Net::HTTP.send :const_set, :Assertions, EventStore::HTTP::Connect::NetHTTP::Assertions

Controls::IPAddress::Loopback::Alias::VerifyAll.() or exit 1
