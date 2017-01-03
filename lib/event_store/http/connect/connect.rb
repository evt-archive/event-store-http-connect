module EventStore
  module HTTP
    class Connect
      include Log::Dependency

      configure :connect

      dependency :resolve_host, DNS::ResolveHost

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
        DNS::ResolveHost.configure instance
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

        begin
          ip_addresses = resolve_ip_address host
        rescue DNS::ResolveHost::ResolutionError => error
          error_message = "Could not connect to EventStore (#{log_attributes}, Error: #{error.class})"
          logger.error error_message
          raise ConnectionError, error
        end

        net_http = nil

        ip_addresses.each_with_index do |ip_address, index|
          net_http = Net::HTTP.new ip_address, port

          net_http.continue_timeout = continue_timeout unless continue_timeout.nil?
          net_http.keep_alive_timeout = keep_alive_timeout unless keep_alive_timeout.nil?
          net_http.open_timeout = open_timeout unless open_timeout.nil?
          net_http.read_timeout = read_timeout unless read_timeout.nil?

          begin
            net_http.start

            break
          rescue Errno::EADDRNOTAVAIL, Errno::ECONNREFUSED, SocketError => error
            error_message = "Could not connect to EventStore (#{log_attributes}, IPAddress: #{ip_address} (#{index.next} of #{ip_addresses.count}), Error: #{error.class})"

            if index + 1 == ip_addresses.count
              logger.error error_message
              raise ConnectionError, error_message
            else
              logger.warn error_message
              net_http = nil
            end
          end
        end

        unless block.nil?
          begin
            block.(net_http)
          ensure
            net_http.finish
          end
        end

        logger.info { "HTTP connection to EventStore established (#{log_attributes}, IPAddress: #{net_http.address})" }

        net_http
      end

      def resolve_ip_address(host)
        logger.trace { "Resolving IP address from host (Host: #{host})" }

        if host == Loopback.hostname
          ip_address = Loopback.ip_address
          logger.debug { "Loopback hostname specified; returning loopback address (Host: #{host}, IPAddress: #{ip_address})" }
          return [ip_address]
        end

        ip_addresses = resolve_host.(host) do |dns_resolver|
          dns_resolver.timeouts = open_timeout
        end

        logger.debug { "Resolved IP address from host (Host: #{host}, IPAddresses: #{ip_address.inspect})" }

        ip_addresses
      end

      def port
        @port ||= Defaults.port
      end

      ConnectionError = Class.new StandardError
    end
  end
end
