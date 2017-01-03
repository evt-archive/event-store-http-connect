module EventStore
  module HTTP
    class Connect
      module NetHTTP
        module Assertions
          def connected?(ip_address: nil, port: nil)
            unless ip_address.nil? || ip_address == self.address
              return false
            end

            unless port.nil? || port == self.port
              return false
            end

            active?
          end

          def closed?
            not active?
          end
        end
      end
    end
  end
end
