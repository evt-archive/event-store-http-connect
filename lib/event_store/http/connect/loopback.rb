module EventStore
  module HTTP
    class Connect
      module Loopback
        def self.hostname
          'localhost'
        end

        def self.ip_address
          '127.0.0.1'
        end
      end
    end
  end
end
