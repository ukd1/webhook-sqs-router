class ApplicationController < ActionController::API
  def index
    render json: {ok: true}
  end

  def queue
    SQS.enqueue({request: {host: request.host, method: request.method, path: params[:path], ts: Time.now.to_s}, params: params})
    render json: {ok: true}
  end
end
