module EventStore
  module HTTP
    class Connect
      module Controls
        module NetHTTP
          def self.example
            net_http = Net::HTTP.new host, port
            net_http.start
            net_http
          end

          def self.host
            IPAddress.example
          end

          def self.port
            Port.example
          end
        end
      end
    end
  end
end
