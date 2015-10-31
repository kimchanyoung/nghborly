class GroupsController < ApplicationController
  def assign
    user = current_user
    user.group_id = find_group(params[:address])

    if user.save
      redirect_to root_path
    else
      redirect :back
    end
  end

  private

  def find_group(address_hash)
    Group.where(address_hash).pluck(id)
  end

end
