module EventStore
  module HTTP
    class Connect
      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :host_resolved
          record :host_resolution_failed
          record :connection_attempt_failed
          record :connection_established
        end

        HostResolved = Struct.new :host, :ip_addresses

        HostResolutionFailed = Struct.new :host, :error

        ConnectionAttemptFailed = Struct.new :host, :ip_address, :port, :error

        ConnectionEstablished = Struct.new :host, :ip_address, :port, :connection
      end
    end
  end
end
