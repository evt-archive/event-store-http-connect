require_relative '../automated_init'

context "Connecting To EventStore Cluster, All Members Are Unavailable" do
  host = Controls::Cluster::Hostname.example

  ip_addresses = Controls::Cluster::IPAddress::Unavailable.list

  connect = EventStore::HTTP::Connect.build

  Controls::ResolveHost.configure connect, host: host, ip_addresses: ip_addresses

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end
end
