describe SQS do
  describe "#queue" do
    subject { SQS.queue }

    it { should be_an(AWS::SQS::Queue) }

    it "caches the object" do
      subject.object_id.should == subject.object_id
    end
  end

  describe "#enqueue" do
    let(:object) { {test: true} }

    it "sends an SQS message" do
      SQS.queue.should_receive(:send_message).with(object.to_json).once.and_return(true)
      SQS.enqueue(object)
    end
  end
end