describe ApplicationController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET / POST 'queue'" do
    it "routes wildcard paths for GET" do
      expect(get: "/some_callback").to route_to(
        controller: "application",
        action: "queue",
        path: 'some_callback'
      )
    end

    it "routes wildcard paths for POST" do
      expect(post: "/some_callback").to route_to(
        controller: "application",
        action: "queue",
        path: 'some_callback'
      )
    end

    let(:path) { 'test_path' }

    it "returns http success and enqueues the message" do
      Timecop.freeze do
        SQS.should_receive(:enqueue).once.with({request: {host: "test.host", method: "GET", path: path, ts: Time.now.to_s}, params: {"path"=>path, "controller"=>"application", "action"=>"queue"}})
        get 'queue', path: path
        response.should be_success

        SQS.should_receive(:enqueue).once.with({request: {host: "test.host", method: "GET", path: path, ts: Time.now.to_s}, params: {"test" => "1", "path"=>path, "controller"=>"application", "action"=>"queue"}})
        get 'queue', path: path, test: 1
        response.should be_success
      end
    end
  end
end