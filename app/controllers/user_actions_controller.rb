class UserActionsController < ApplicationController

  before_action :logged_in?, only: [:new, :create]

  private

  def logged_in?
    unless current_user
      # Redirect to page that has the login here
      redirect_to login_path
    end
  end

end