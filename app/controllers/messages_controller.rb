class MessagesController < ApplicationController
  #before_action :require_login
  #before_action :validate_request_status, only: [:create]

  def index
    #@messages = @request.messages
  end

  def create
  end

  private

  def require_login
    unless current_user == @request.requester || current_user == @request.responder
      flash[:error] = "This action requires you to be logged in"
      redirect_to login_path
    end
  end

  def validate_request_status
    unless @request.active?
      flash[:error] = "This request is no longer active."
    end
  end

 def find_request
  @request = Request.find_by(id: params[:request_id]).messages.include(:messages)
 end
end
