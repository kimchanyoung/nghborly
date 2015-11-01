class RequestsController < UserActionsController
  before_action :can_view?, only: [:show]

  def index
    @requests = Request.where(group_id: current_user.group_id)
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_attributes)

    if @request.save
      Transaction.create(request_id: @request.id, transaction_type: 'request')
      current_user.group.users.each do |user|
        NewRequestMailer.notify(@request, user).deliver_now
      end
      redirect_to request_path(@request)
    else
      flash[:alert] = @request.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def show
  end

  def update
    @request = Request.find_by(id: params[:id])
    if !@request.is_fulfilled
      @request.responder = current_user if @request.requester != current_user
      if @request.save
        Transaction.create(request_id: @request.id, transaction_type: 'response')
        flash[:success] = "Thanks for being a good neighbor!"
        redirect_to request_path(@request)
      else
        flash[:error] = @request.errors.full_messages.join(', ')
        redirect_to "show"
      end
    else
      if current_user == @request.requester || current_user == @request.responder
        @request.update_attribute(:is_fulfilled, true)
        Transaction.create(request_id: @request.id, transaction_type: 'fulfillment')
        redirect_to request_path(@request)
      else
        flash[:error] = "You are not a party in this transaction!"
        redirect_to root_path
      end
    end
  end

  def destroy
    request = Request.find_by(id: params[:id])
    if request.requester == current_user
      request.destroy
      flash[:success] = 'Request successfully cancelled!'
    else
      flash[:error] = "You cannot cancel someone else's request!"
    end
    redirect_to root_path
  end

  def other_party_of(request)
    if current_user == request.requester
      request.responder
    elsif current_user == request.responder
      request.requester
    end
  end

  def can_view?
    @request = Request.find_by(id: params[:id])

    if @request.responder.nil?
      current_user.group == @request.group
    else
      @request.is_party_to?(current_user)
    end
  end

  private

  def request_attributes
    known_attrs = {requester_id: current_user.id, group_id: current_user.group_id}
    params.require(:request).permit(:content).merge(known_attrs)
  end
end
