module EventStore
  module HTTP
    class Connect
      module Controls
        module IPAddress
          def self.example
            Loopback::Alias.example
          end

          module Other
            def self.example
              Loopback::Alias.example third_octet: 1
            end
          end

          module Loopback
            def self.example
              '127.0.0.1'
            end

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
            end
          end

          module NonRoutable
            def self.example
              '127.0.0.0'
            end
          end

          module Cluster
            def self.example(member_index=nil)
              Loopback::Alias.example member_index, third_octet: 111
            end

            def self.list
              (1..Controls::Cluster::Size.example).map do |member_index|
                example member_index
              end
            end

            module Unavailable
              def self.example(member_index=nil)
                Loopback::Alias.example member_index, third_octet: 222
              end

              def self.list
                (1..Controls::Cluster::Size.example).map do |member_index|
                  example member_index
                end
              end
            end

            module PartiallyAvailable
              def self.example(member_index=nil)
                member_index ||= 1

                if member_index == 1
                  Unavailable.example member_index
                else
                  Cluster.example member_index
                end
              end

              def self.list
                (1..Controls::Cluster::Size.example).map do |member_index|
                  example member_index
                end
              end
            end
          end
        end
      end
    end
  end
end
