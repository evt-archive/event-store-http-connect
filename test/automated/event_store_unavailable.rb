require_relative './automated_init'

context "EventStore Is Unavailable" do
  host = Controls::IPAddress::Unavailable.example

  connect = EventStore::HTTP::Connect.build

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end
end
