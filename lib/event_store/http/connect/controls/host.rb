module EventStore
  module HTTP
    class Connect
      module Controls
        module Host
          def self.example
            Hostname.example
          end

          module Cluster
            def self.example
              Hostname::Cluster.example
            end
          end

          module Other
            def self.example
              IPAddress.example
            end
          end

          module Unavailable
            def self.example
              external
            end

            def self.external
              local_ip_address_list = Socket.ip_address_list

              local_ip_address_list.map! &:ip_address

              local_ip_address_list.find do |ip_address|
                ip_address != IPAddress::Loopback.example
              end
            end
          end
        end
      end
    end
  end
end
