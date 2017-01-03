module EventStore
  module HTTP
    class Connect
      module Controls
        module Port
          def self.example
            Connect::Defaults.port
          end

          module Unused
            def self.get
              localhost = IPAddress::Loopback.example

              (10000..19999).each do |port|
                begin
                  socket = TCPSocket.new localhost, port
                  socket.close
                  next

                rescue Errno::ECONNREFUSED
                  return port
                end
              end

              fail
            end
          end
        end
      end
    end
  end
end
