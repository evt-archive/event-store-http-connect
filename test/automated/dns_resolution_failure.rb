require_relative './automated_init'

context "DNS Resolution Failure When Resolving Hostname" do
  host = Controls::Hostname::Other.example randomize: true

  connect = EventStore::HTTP::Connect.build
  connect.open_timeout = 0.01

  comment "Establishing connection in order to warm DNS cache"

  begin
    connect.(host)
  rescue EventStore::HTTP::Connect::ConnectionError
  end

  test "Connection error is raised" do
    assert proc { connect.(host) } do
      raises_error? EventStore::HTTP::Connect::ConnectionError
    end
  end
end
