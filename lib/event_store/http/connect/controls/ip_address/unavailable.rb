module EventStore
  module HTTP
    class Connect
      module Controls
        module IPAddress
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
