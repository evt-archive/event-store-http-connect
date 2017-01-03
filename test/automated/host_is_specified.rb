require_relative './automated_init'

context "Host Is Specified" do
  host = Controls::Host::Other.example

  connect = EventStore::HTTP::Connect.build

  connection = connect.(host)

  test "Specified host is used to establish connection" do
    assert connection do
      connected? host: host
    end
  end

  test "Host setting is not used to establish connection" do
    refute connection do
      connected? host: Controls::Host.example
    end
  end
end
