module EventStore
  module HTTP
    class Connect
      module Controls
        module Settings
          def self.example(host: nil, namespace: nil, **attributes)
            host ||= IPAddress.example
            namespace = Array(namespace)

            attributes[:host] = host

            data_source = namespace.reduce attributes do |hash, namespace|
              { namespace => hash }
            end

            EventStore::HTTP::Connect::Settings.build data_source
          end
        end
      end
    end
  end
end
