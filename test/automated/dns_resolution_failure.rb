require_relative './automated_init'

context "DNS Resolution Failure When Resolving Hostname" do
  host = Controls::Hostname::Other.example randomize: true

  connect = EventStore::HTTP::Connect.build
  connect.open_timeout = 0.01

  comment "Establishing connection in order to warm DNS cache"

  begin
    connect.(host)
  rescue EventStore::HTTP::Connect::ConnectionError
  end

  telemetry_sink = EventStore::HTTP::Connect.register_telemetry_sink connect

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end

  context "Telemetry" do
    context "Host resolution failed record" do
      record, * = telemetry_sink.host_resolution_failed_records

      test "Is recorded" do
        assert record
      end

      test "Host is set" do
        assert record.data.host == host
      end

      test "Root cause error is included" do
        assert record.data.error do
          instance_of? DNS::ResolveHost::ResolutionError
        end
      end
    end
  end
end
