module EventStore
  module HTTP
    class Connect
      module Controls
        module ResolveHost
          def self.configure(receiver, host: nil, ip_addresses: nil)
            host ||= Hostname.example
            ip_addresses ||= [IPAddress.example]

            resolve_host = SubstAttr::Substitute.(:resolve_host, receiver)
            resolve_host.set host, ip_addresses
            resolve_host
          end
        end
      end
    end
  end
end
