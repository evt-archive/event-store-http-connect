module EventStore
  module HTTP
    class Connect
      module Controls
        module IPAddress
          module Loopback
            module Alias
              def self.example(fourth_octet=nil, third_octet: nil)
                third_octet ||= 0

                if third_octet == 0
                  fourth_octet ||= 2
                else
                  fourth_octet ||= 1
                end

                "127.0.#{third_octet}.#{fourth_octet}"
              end

              module VerifyAll
                def self.call
                  port = Port::Unused.get

                  unaliased_ip_addresses = list.select do |ip_address|
                    begin
                      server = TCPServer.new ip_address, port
                      server.close
                      false
                    rescue Errno::EADDRNOTAVAIL
                      true
                    end
                  end

                  return true if unaliased_ip_addresses.none?

                  warn <<~MESSAGE
                  The following loopback aliases are not configured:

                      #{unaliased_ip_addresses * "\n    "}

                  To setup a loopback alias, run the following command:

                      sudo ifconfig lo0 alias 127.0.111.1

                  Note that the above command was tested on OS X and may vary
                  on Linux systems.
                  MESSAGE

                  false
                end

                def self.list
                  [
                    Alias.example,
                    *Cluster::IPAddress.list,
                    *Cluster::IPAddress::Unavailable.list
                  ]
                end
              end
            end
          end
        end
      end
    end
  end
end
