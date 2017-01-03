require_relative '../automated_init.rb'

context "Connected predicate" do
  context "Host and port are not specified" do
    net_http = Controls::NetHTTP.example

    context "Connection is open" do
      test "True is returned" do
        assert net_http, &:connected?
      end
    end

    context "Connection is closed" do
      net_http.finish

      test "False is returned" do
        refute net_http, &:connected?
      end
    end
  end

  context "IP address is specified" do
    net_http = Controls::NetHTTP.example

    context "Specified host does not match that of connection" do
      test "True is returned" do
        refute net_http do
          connected? ip_address: 'other-host'
        end
      end
    end

    context "Specified host matches that of connection" do
      context "Connection is open" do
        test "True is returned" do
          assert net_http do
            connected? ip_address: Controls::IPAddress.example
          end
        end
      end

      context "Connection is closed" do
        net_http.finish

        test "False is returned" do
          refute net_http do
            connected? ip_address: Controls::IPAddress.example
          end
        end
      end
    end
  end

  context "Port is specified" do
    net_http = Controls::NetHTTP.example

    context "Specified port does not match that of connection" do
      test "False is returned" do
        refute net_http do
          connected? port: 1111
        end
      end
    end

    context "Specified port matches that of connection" do
      context "Connection is open" do
        test "True is returned" do
          assert net_http do
            connected? port: Controls::NetHTTP.port
          end
        end
      end

      context "Connection is closed" do
        net_http.finish

        test "False is returned" do
          refute net_http do
            connected? port: Controls::NetHTTP.port
          end
        end
      end
    end
  end
end
