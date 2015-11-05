class MessagesController < UserActionsController
  before_action :set_request, :verify_association
  before_action :validate_request_status, only: [:create]

  def index
    @messages = @request.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      trigger_message_event(@message)
      redirect_to request_messages_path(@request, anchor: 'bottom')
    else
      flash[:now] = @message.errors.full_messages.join(', ')
      redirect_to request_messages_path(@request, anchor: 'bottom')
    end
  end

  private

 def set_request
  @request = Request.find_by(id: params[:request_id])
 end

 def verify_association
   unless @request.is_party_to?(current_user)
     redirect_to request_path(@request)
   end
 end

  def validate_request_status
    unless (@request.responder && !@request.is_fulfilled)
      flash[:error] = "This request is no longer active."
      redirect_to request_messages_path(@request)
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
