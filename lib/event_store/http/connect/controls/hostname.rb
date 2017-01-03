module EventStore
  module HTTP
    class Connect
      module Controls
        module Hostname
          def self.example(suffix=nil)
            if suffix.nil?
              'eventstore.local'
            else
              "eventstore-#{suffix}.local"
            end
          end

          module Cluster
            def self.example
              Hostname.example 'cluster'
            end
          end

          module Localhost
            def self.example
              'localhost'
            end
          end

          module Other
            def self.example(randomize: nil)
              if randomize
                random = SecureRandom.hex 7

                "some-hostname-#{random}"
              else
                'some-hostname'
              end
            end
          end
        end
      end
    end
  end
end
