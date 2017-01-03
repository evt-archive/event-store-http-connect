require_relative './automated_init'

context "Host Is Specified" do
  host = Controls::Host::Other.example

  connect = EventStore::HTTP::Connect.build

  Controls::ResolveHost.configure connect, host: host

  connection = connect.(host)

  test "IP address is resolved from specified host and used to establish connection" do
    assert connection do
      connected? ip_address: Controls::IPAddress.example
    end
  end

  test "Host setting is not used to establish connection" do
    refute connection do
      connected? ip_address: Controls::Host.example
    end
  end
end
