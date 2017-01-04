require_relative '../automated_init'

context "Connecting To EventStore Cluster, First Member Is Unavailable" do
  host = Controls::Cluster::Hostname.example

  ip_addresses = Controls::Cluster::IPAddress::PartiallyAvailable.list

  connect = EventStore::HTTP::Connect.build

  Controls::Cluster::ResolveHost.configure connect, ip_addresses: ip_addresses

  telemetry_sink = EventStore::HTTP::Connect.register_telemetry_sink connect

  connection = connect.(host)

  test "Net::HTTP instance is returned" do
    assert connection.instance_of?(Net::HTTP)
  end

  test "Connection is established with second IP address returned by DNS query" do
    control_ip_address = Controls::Cluster::IPAddress.example 2

    assert connection do
      connected? ip_address: control_ip_address
    end
  end

  context "Telemetry" do
    test "Failed connection attempt made with first member is recorded" do
      assert telemetry_sink do
        recorded_connection_attempt_failed?
      end
    end
  end
end
