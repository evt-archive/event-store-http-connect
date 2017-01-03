module EventStore
  module HTTP
    class Connect
      module Controls
        module ResolveHost
          def self.configure(receiver, host: nil, ip_addresses: nil)
            host ||= Controls::Hostname.example
            ip_addresses ||= [Controls::IPAddress.example]

            resolve_host = SubstAttr::Substitute.(:resolve_host, receiver)
            resolve_host.set host, ip_addresses
            resolve_host
          end
        end
      end
    end
  end
end
