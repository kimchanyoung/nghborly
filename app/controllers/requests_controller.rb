class RequestsController < ApplicationController
  before_action :require_login

  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_attributes)
    @request.requester = current_user
    if @request.save
      current_user.group.users.each do |user|
        NewRequestMailer.notify(@request, user)
      end
      redirect_to request(@request)
    else
      flash[:alert] = @request.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def show
    @request = Request.find_by(id: params[:id])
  end

  def update
    request = Request.find_by(id: params[:id])
    request.responder = current_user if request.requester != current_user
    flash[:success] = "Thanks for being a good neighbor!"
    redirect_to request(@request)
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

  private

  def request_attributes
    params.require(:request).permit(:content)
  end

  def require_login
    unless logged_in?
      flash[:error] = 'Please log in to be a good neighbor!'
      redirect_to login_path
    end
  end

end