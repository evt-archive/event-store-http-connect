require_relative './automated_init'

context "DNS Resolution Failure When Resolving Hostname" do
  host = Controls::IPAddress::NonRoutable.example

  connect = EventStore::HTTP::Connect.build

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end
end
