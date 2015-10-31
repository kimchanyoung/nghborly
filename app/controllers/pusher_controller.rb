class PusherController < ApplicationController
  protect_from_forgery except: :auth

  def auth
    puts params
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    render json: response
=begin
    request = find_request(params[:channel_name])

    if current_user == request.requester || current_user == request.responder
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render text: "Not authorized", status: 403
    end
=end
  end

  private

  def find_request(channel_name)
    channel_id = channel_name.sub('private-', '')
    Request.find_by(id: channel_id).include(:requester, :responder)
  end
end
