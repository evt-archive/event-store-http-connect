module EventStore
  module HTTP
    class Connect
      module NetHTTP
        module Assertions
          def connected?(host: nil, port: nil)
            unless host.nil? || host == self.address
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
