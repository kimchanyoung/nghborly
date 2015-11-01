class UserActionsController < ApplicationController
  before_action :logged_in?
  before_action :assigned_to_group

  private

  def logged_in?
    unless current_user
      redirect_to login_path
    end
  end

  def assigned_to_group
    if current_user.group.nil?
      redirect_to groups_assign_path
    end
  end
end
