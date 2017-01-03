require_relative './automated_init'

context "Connect Build Method" do
  context "Settings argument is not supplied" do
    connect = EventStore::HTTP::Connect.build

    test "Project local settings are used" do
      control_settings = EventStore::HTTP::Connect::Settings.build

      assert connect do
        settings? control_settings
      end
    end
  end

  context "Settings argument is supplied" do
    settings = EventStore::HTTP::Connect::Settings.build({
      :host => 'some-host'
    })

    connect = EventStore::HTTP::Connect.build settings

    test "Supplied settings are used" do
      control_settings = settings

      assert connect do
        settings? control_settings
      end
    end

    test "Project local settings are not used" do
      control_settings = EventStore::HTTP::Connect::Settings.build

      refute connect do
        settings? control_settings
      end
    end
  end

  context "Namespace is supplied" do
    settings = EventStore::HTTP::Connect::Settings.build({
      :some_namespace => {
        :host => 'some-host'
      }
    })

    connect = EventStore::HTTP::Connect.build settings, namespace: :some_namespace

    test "Supplied settings are used" do
      control_settings = settings

      assert connect do
        settings? control_settings, namespace: :some_namespace
      end
    end
  end
end
