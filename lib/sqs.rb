class SQS
  def self.queue
    @q ||= AWS::SQS::Queue.new(SQS_QUEUE, AWS.config(SQS_CONFIG))
  end

  def self.enqueue(item)
    queue.send_message(item.to_json)
  end
end