module EventStore
  module HTTP
    class Connect
      module Assertions
        def settings?(settings, namespace: nil)
          namespace = Array(namespace)

          Settings.names.all? do |name|
            settings_value = settings.get name, *namespace

            if settings_value.nil?
              true
            else
              instance_value = __send__ name

              instance_value == settings_value
            end
          end
        end
      end
    end
  end
end
