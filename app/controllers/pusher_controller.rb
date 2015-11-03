class PusherController < ApplicationController
  def groupauth
    if authorize_presence_channel
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {user_id: current_user.id})
      render json: response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  def auth
    if authorize_private_channel
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  private

  def authorize_presence_channel
    channel_postfix = params[:channel_name].sub('presence-', '')
    current_user.group.id == channel_postfix.to_i
  end

  def authorize_private_channel
    request = Request.find_by(id: params[:request_id])
    request.is_party_to?(current_user)
  end
end
