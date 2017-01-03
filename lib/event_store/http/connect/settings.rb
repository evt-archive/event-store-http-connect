module EventStore
  module HTTP
    class Connect
      class Settings < ::Settings
        def self.data_source
          'settings/event_store_http.json'
        end

        def self.names
          %i(
            host
            port
            continue_timeout
            read_timeout
            open_timeout
          )
        end
      end
    end
  end
end
