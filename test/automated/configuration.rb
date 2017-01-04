require_relative './automated_init'

context "Configuration" do
  context "Attribute name is not specified" do
    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver

    test "Connect instance is returned" do
      assert connect.instance_of?(EventStore::HTTP::Connect)
    end

    test "Connect instance is assigned to default attribute name on receiver" do
      assert receiver.connect == connect
    end
  end

  context "Attribute name is specified" do
    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver, attr_name: :some_attr

    test "Connect instance is assigned to specified attribute name on receiver" do
      assert receiver.some_attr == connect
    end
  end

  context "Settings are specified" do
    settings = Controls::Settings.example read_timeout: 111

    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver, settings

    test "Connection is established with EventStore specified by settings" do
      assert connect.read_timeout == 111
    end
  end

  context "Settings namespace is specified" do
    settings = Controls::Settings.example read_timeout: 111, namespace: :some_namespace

    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver, settings, namespace: :some_namespace

    test "Connection is established with EventStore specified by settings" do
      assert connect.read_timeout == 111
    end
  end

  context "Connect instance is supplied" do
    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.new

    EventStore::HTTP::Connect.configure receiver, connect: connect

    test "Supplied instance is assigned to receiver" do
      assert receiver.connect == connect
    end
  end
end
