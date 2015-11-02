class PusherController < ApplicationController
  def groupauth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {user_id: current_user.id})
    render json: response
  end

  def auth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    render json: response
  end
end
