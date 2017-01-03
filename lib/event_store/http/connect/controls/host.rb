module EventStore
  module HTTP
    class Connect
      module Controls
        module Host
          def self.example
            Hostname.example
          end

          module Other
            def self.example
              IPAddress.example
            end
          end

          module Unavailable
            def self.example
              local_ip_address_list = Socket.ip_address_list

              local_ip_address_list.map! &:ip_address

              local_ip_address_list.find do |ip_address|
                ip_address != IPAddress.loopback
              end
            end
          end
        end
      end
    end
  end
end
