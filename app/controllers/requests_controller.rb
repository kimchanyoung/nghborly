class RequestsController < UserActionsController
  before_action :check_rate_limit, only: [:create]

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
        NewRequestMailer.notify(@request, user).deliver_now if user != current_user
      end
      redirect_to request_path(@request)
    else
      flash.now[:alert] = @request.errors.full_messages.join(", ")
      render 'welcome/index'
    end
  end

  def show
    @request = Request.find_by(id: params[:id])

    unless @request.can_view?(current_user)
      flash[:alert] = "One of your neighbors is already fulfilling that request!"
      redirect_to requests_path
    end
  end

  def update
    @request = Request.find_by(id: params[:id])
    if @request.responder == nil && @request.requester != current_user
      @request.responder = current_user if @request.requester != current_user
      respond
    elsif @request.requester == current_user
      fulfill
    end
  end

  def respond
    if @request.save
      NewResponderMailer.notify(@request, @request.requester).deliver_now
      Transaction.create(request_id: @request.id, transaction_type: 'response')
      flash[:success] = "Thanks for being a good neighbor!"
      redirect_to request_path(@request)
    else
      flash[:alert] = @request.errors.full_messages.join(', ')
      redirect_to root_path
    end
  end

  def fulfill
    if current_user == @request.requester
      @request.is_fulfilled = true
      if @request.save
        Transaction.create(request_id: @request.id, transaction_type: 'fulfillment')
        redirect_to request_path(@request)
      else
        redirect_to requests_path
      end
    else
      flash[:alert] = "You are not a party in this transaction!"
      redirect_to root_path
    end
  end

  def destroy
    request = Request.find_by(id: params[:id])
    if request.requester == current_user
      request.destroy
      flash[:success] = 'Request successfully cancelled!'
    else
      flash[:alert] = "You cannot cancel someone else's request!"
    end
    redirect_to root_path
  end


  def check_rate_limit
    if current_user.requests_in_last_24_hours > 5
      flash[:alert] = "You've exceeded your quota. You're neighbors need some rest!"
      redirect_to root_path
    end
  end

  def active
    @requests = Request.order('created_at DESC').limit(25).select{ |req| req.active? && req.group == current_user.group }

    if request.xhr?
      render 'requests/index.html.erb', layout: false
    else
      render 'requests/index.html.erb'
    end
  end

  def history
    @requests = Request.order('created_at DESC').limit(25).where('responder_id = ? OR requester_id = ?', current_user.id, current_user.id).where('is_fulfilled = ?', false)
    if request.xhr?
      render 'requests/index.html.erb', layout: false
    else
      render 'requests/index.html.erb'
    end
  end

  private

  def get_request
    request = Request.find_by(id: params[:id])
  end

  def request_attributes
    known_attrs = {requester_id: current_user.id, group_id: current_user.group_id}
    params.require(:request).permit(:content).merge(known_attrs)
  end
end
