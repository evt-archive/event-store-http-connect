module EventStore
  module HTTP
    class Connect
      class Log < ::Log
        def tag!(tags)
          tags << :event_store_http_log
          tags << :db_connection
          tags << :verbose
        end
      end
    end
  end
end
