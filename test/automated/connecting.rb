require_relative './automated_init'

context "Connecting To EventStore HTTP Interface" do
  context do
    connection = EventStore::HTTP::Connect.()

    test "Net::HTTP instance is returned" do
      assert connection.instance_of?(Net::HTTP)
    end

    test "Connection is established with host and port specified by settings" do
      assert connection do
        connected?(
          ip_address: Controls::IPAddress.example,
          port: Controls::Port.example
        )
      end
    end

    test "Continue timeout is set" do
      assert connection.continue_timeout == Controls::Timeouts.continue
    end

    test "Open timeout is set" do
      assert connection.open_timeout == Controls::Timeouts.open
    end

    test "Read timeout is set" do
      assert connection.read_timeout == Controls::Timeouts.read
    end
  end

  context "Port is not specified by settings" do
    settings = EventStore::HTTP::Connect::Settings.build({
      :host => Controls::Hostname.example
    })

    connection = EventStore::HTTP::Connect.(settings)

    test "EventStore default for external HTTP (2113) is used" do
      assert connection do
        connected? port: Controls::Port.example
      end
    end
  end

  context "Timeouts are not specified by settings" do
    settings = EventStore::HTTP::Connect::Settings.build({
      :host => Controls::Hostname.example,
      :port => Controls::Port.example
    })

    connection = EventStore::HTTP::Connect.(settings)

    test "Continue timeout is not set" do
      assert connection.continue_timeout == nil
    end

    test "Net::HTTP default value for keep alive timeout (2s) is used" do
      assert connection.keep_alive_timeout == Controls::NetHTTP::Defaults.keep_alive_timeout
    end

    test "Net::HTTP default value for open timeout (60s) is used" do
      assert connection.open_timeout == Controls::NetHTTP::Defaults.open_timeout
    end

    test "Net::HTTP default value for read timeout (60s) is used" do
      assert connection.read_timeout == Controls::NetHTTP::Defaults.read_timeout
    end
  end
end
