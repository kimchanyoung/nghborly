class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    redirect_to new_request and return unless logged_in?
    @request = Request.new(request_attributes)
    @request.requester = current_user
    if @request.save
      redirect_to request(@request)
    else
      flash.new[:alert] = @request.errors.full_messages.join(", ")
      render 'new'
    end
  end

  private

  def request_attributes
    params.require(:request).permit(:content)
  end

end