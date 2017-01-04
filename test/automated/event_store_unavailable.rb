require_relative './automated_init'

context "EventStore Is Unavailable" do
  host = Controls::IPAddress::Unavailable.example

  connect = EventStore::HTTP::Connect.build

  telemetry_sink = EventStore::HTTP::Connect.register_telemetry_sink connect

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end

  context "Telemetry" do
    test "Connection attempt failed record" do
      record, * = telemetry_sink.connection_attempt_failed_records

      test "Is recorded" do
        assert record
      end

      test "Host is set" do
        assert record.data.host == host
      end

      test "Port is set" do
        assert record.data.port == Controls::Port.example
      end

      test "IP address resolved from host is included" do
        assert record.data.ip_address == Controls::IPAddress::Unavailable.example
      end

      test "Root cause error is included" do
        assert record.data.error do
          instance_of? Errno::ECONNREFUSED
        end
      end
    end
  end
end
