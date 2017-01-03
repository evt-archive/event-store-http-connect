require_relative './automated_init'

context "Connecting To EventStore HTTP Interface On Localhost" do
  host = Controls::Hostname::Localhost.example

  connection = EventStore::HTTP::Connect.(host: 'localhost')

  test "Net::HTTP instance is returned" do
    assert connection.instance_of?(Net::HTTP)
  end

  test "Connection is established with loopback address (127.0.0.1)" do
    assert connection do
      connected?(
        ip_address: Controls::IPAddress::Loopback.example
      )
    end
  end
end
