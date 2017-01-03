require_relative '../automated_init.rb'

context "Closed predicate" do
  context "Connection is open" do
    net_http = Controls::NetHTTP.example

    test "False is returned" do
      refute net_http, &:closed?
    end
  end

  context "Connection is closed" do
    net_http = Controls::NetHTTP.example

    net_http.finish

    test "True is returned" do
      assert net_http, &:closed?
    end
  end
end
