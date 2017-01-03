require_relative '../automated_init'

context "Connecting To EventStore Cluster, First Member Is Unavailable" do
  host = Controls::Cluster::Hostname.example

  ip_addresses = Controls::Cluster::IPAddress::PartiallyAvailable.list

  connect = EventStore::HTTP::Connect.build

  Controls::ResolveHost.configure connect, host: host, ip_addresses: ip_addresses

  connection = connect.(host)

  test "Net::HTTP instance is returned" do
    assert connection.instance_of?(Net::HTTP)
  end

  test "Connection is established with second IP address returned by DNS query" do
    assert connection do
      connected? ip_address: ip_addresses[1]
    end
  end
end
