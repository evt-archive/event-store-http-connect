module EventStore
  module HTTP
    class Connect
      module Controls
        module Cluster
          module ResolveHost
            def self.configure(receiver, host: nil, ip_addresses: nil)
              host ||= Hostname.example
              ip_addresses ||= IPAddress.list

              Controls::ResolveHost.configure(
                receiver,
                host: host,
                ip_addresses: ip_addresses
              )
            end
          end
        end
      end
    end
  end
end
