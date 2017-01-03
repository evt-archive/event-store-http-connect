require_relative '../automated_init'

context "Connecting To EventStore Cluster, All Members Are Available" do
  host = Controls::Cluster::Hostname.example

  connect = EventStore::HTTP::Connect.build

  Controls::Cluster::ResolveHost.configure connect

  connection = connect.(host)

  test "Net::HTTP instance is returned" do
    assert connection.instance_of?(Net::HTTP)
  end

  test "Connection is established with first IP address returned by DNS query" do
    control_ip_address = Controls::Cluster::IPAddress.example 1

    assert connection do
      connected? ip_address: control_ip_address
    end
  end
end
