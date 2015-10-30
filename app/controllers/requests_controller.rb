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
      redirect_to request(@request)
    else
      flash.now[:alert] = @request.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def show
    @request = Request.find_by(id: params[:id])
  end

  def update
    request = Request.find_by(id: params[:id])
    request.responder = current_user if request.requester != current_user
    redirect_to request(@request)
  end

  def destroy
    request = Request.find_by(id: params[:id])
    request.destroy if request.requester == current user
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