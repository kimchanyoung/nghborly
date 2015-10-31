class MessagesController < ApplicationController
  before_action :set_request, :require_login, :verify_association
  before_action :validate_request_status, only: [:create]

  def index
    @messages = @request.messages
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      trigger_message_event(@message)
      redirect_to request_messages_path(@request)
    else
      flash[:now] = @message.errors.full_messages.join(', ')
      render request_messages_path(@request)
    end
  end

  private

 def set_request
  @request = Request.find_by(id: params[:request_id])
 end

  def require_login
    unless current_user
      flash[:error] = "You must be loged in to before this action".
      redirect_to login_path
    end
  end

  def verify_association
    unless current_user == @request.requester || current_user == @request.responder
      flash[:error] = "You are not a party to this neighborly request."
      redirect_to root_path
    end
  end

  def validate_request_status
    unless @request.active?
      flash[:error] = "This request is no longer active."
    end
  end

  def message_params
    known_attrs = {sender_id: current_user.id, request_id: @request.id}

    params.require(:message).permit(:content).merge(known_attrs)
  end

  def trigger_message_event(message)
    Pusher["private-#{@request.id}"].trigger('new_message', {content: message.content})
  end
end
