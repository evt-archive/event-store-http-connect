module EventStore
  module HTTP
    class Connect
      include Log::Dependency

      configure :connect

      setting :host
      setting :port

      setting :continue_timeout
      setting :keep_alive_timeout
      setting :open_timeout
      setting :read_timeout

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.build
        namespace = Array(namespace)

        instance = new
        settings.set instance, *namespace
        instance
      end

      def self.call(settings=nil, namespace: nil, host: nil)
        instance = build settings, namespace: namespace
        instance.(host)
      end

      def call(host=nil, &block)
        log_attributes = LogAttributes.get self, host: host

        host ||= self.host

        logger.trace { "Establishing HTTP connection to EventStore (#{log_attributes})" }

        net_http = Net::HTTP.new host, port

        net_http.continue_timeout = continue_timeout unless continue_timeout.nil?
        net_http.keep_alive_timeout = keep_alive_timeout unless keep_alive_timeout.nil?
        net_http.open_timeout = open_timeout unless open_timeout.nil?
        net_http.read_timeout = read_timeout unless read_timeout.nil?

        begin
          net_http.start
        rescue Errno::EADDRNOTAVAIL, Errno::ECONNREFUSED, Net::OpenTimeout, SocketError => error
          error_message = "Could not connect to EventStore (#{log_attributes}, Error: #{error.class})"
          logger.error error_message
          raise ConnectionError, error
        end

        unless block.nil?
          begin
            block.(net_http)
          ensure
            net_http.finish
          end
        end

        logger.info { "HTTP connection to EventStore established (#{log_attributes})" }

        net_http
      end

      def port
        @port ||= Defaults.port
      end

      ConnectionError = Class.new StandardError
    end
  end
end
