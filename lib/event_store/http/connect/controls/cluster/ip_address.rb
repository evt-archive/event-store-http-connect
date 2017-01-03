module EventStore
  module HTTP
    class Connect
      module Controls
        module Cluster
          module IPAddress
            def self.example(member_index=nil, third_octet: nil)
              member_index ||= 1
              third_octet ||= 111

              Controls::IPAddress::Loopback::Alias.example(
                member_index,
                third_octet: third_octet
              )
            end

            module List
              def list
                (1..Size.example).map do |member_index|
                  example member_index
                end
              end
            end
            extend List

            module Unavailable
              extend List

              def self.example(member_index=nil)
                IPAddress.example member_index, third_octet: 222
              end
            end

            module PartiallyAvailable
              extend List

              def self.example(member_index=nil)
                member_index ||= nil

                if member_index == 1
                  Unavailable.example member_index
                else
                  IPAddress.example member_index
                end
              end
            end
          end
        end
      end
    end
  end
end
