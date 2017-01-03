module EventStore
  module HTTP
    class Connect
      module Controls
        module Hostname
          def self.example
            'localhost'
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
