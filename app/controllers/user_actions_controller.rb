class UserActionsController < ApplicationController
  before_action :assigned_to_group
  before_action :logged_in?, only: [:new, :create]

  private

  def logged_in?
    unless current_user
      redirect_to login_path
    end
  end

  def assigned_to_group
    if current_user.group.nil?
      redirect_to groups_assign
    end
  end
end
