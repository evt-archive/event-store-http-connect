require_relative './automated_init'

context "Connecting To EventStore HTTP Interface, Telemetry" do
  connect = EventStore::HTTP::Connect.build

  Controls::ResolveHost.configure connect

  telemetry_sink = EventStore::HTTP::Connect.register_telemetry_sink connect

  connection = connect.()

  test "Host resolved record" do
    record, * = telemetry_sink.host_resolved_records

    test "Is recorded" do
      assert record
    end

    test "Host is set" do
      assert record.data.host == Controls::Host.example
    end

    test "IP address returned by DNS lookup is included" do
      assert record.data.ip_addresses == [Controls::IPAddress.example]
    end
  end

  test "Connection established record" do
    record, * = telemetry_sink.connection_established_records

    test "Is recorded" do
      assert record
    end

    test "Host is set" do
      assert record.data.host == Controls::Host.example
    end

    test "Port is set" do
      assert record.data.port == Controls::Port.example
    end

    test "IP address resolved from host is included" do
      assert record.data.ip_address == Controls::IPAddress.example
    end

    test "Connection is returned" do
      assert record.data.connection == connection
    end
  end
end
