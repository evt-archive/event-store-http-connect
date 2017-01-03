module EventStore
  module HTTP
    class Connect
      class Log < ::Log
        def tag!(tags)
          tags << :event_store_http_connect
          tags << :event_store
          tags << :verbose
        end
      end
    end
  end
end
