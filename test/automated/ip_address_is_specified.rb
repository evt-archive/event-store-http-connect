require_relative './automated_init'

context "IP Address Is Specified" do
  host = Controls::IPAddress.example

  connect = EventStore::HTTP::Connect.build

  connection = connect.(host)

  test "Specified IP address is used to establish connection" do
    assert connection do
      connected? ip_address: Controls::IPAddress.example
    end
  end
end
