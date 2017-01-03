module EventStore
  module HTTP
    class Connect
      module LogAttributes
        def self.get(connect, host: nil)
          if host.nil?
            host_text = connect.host
          else
            host_text = "#{host} [Overriding setting: #{connect.host}]"
          end

          connect.instance_exec do
            "Host: #{host_text}, Port: #{port}, KeepAliveTimeout: #{keep_alive_timeout || '(default)'}, ReadTimeout: #{read_timeout || '(default)'}, OpenTimeout: #{open_timeout || '(default)'}, ContinueTimeout: #{continue_timeout || '(none)'}"
          end
        end
      end
    end
  end
end
