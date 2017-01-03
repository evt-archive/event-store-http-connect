module EventStore
  module HTTP
    class Connect
      module Controls
        module Timeouts
          def self.continue
            1
          end

          def self.keep_alive
            2
          end

          def self.open
            3
          end

          def self.read
            4
          end
        end
      end
    end
  end
end
