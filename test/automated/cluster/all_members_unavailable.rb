require_relative '../automated_init'

context "Connecting To EventStore Cluster, All Members Are Unavailable" do
  host = Controls::Host::Cluster.example

  ip_addresses = Controls::IPAddress::Cluster::Unavailable.list

  connect = EventStore::HTTP::Connect.build

  resolve_host = SubstAttr::Substitute.(:resolve_host, connect)
  resolve_host.set host, ip_addresses

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end
end
