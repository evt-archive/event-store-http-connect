module EventStore
  module HTTP
    class Connect
      module Controls
        module IPAddress
          def self.example
            loopback
          end

          def self.loopback
            '127.0.0.1'
          end

          module NonRoutable
            def self.example
              '127.0.0.0'
            end
          end
        end
      end
    end
  end
end
