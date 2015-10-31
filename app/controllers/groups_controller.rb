class GroupsController < ApplicationController
  def inquire
  end

  def assign
    user = current_user
    user.group_id = find_group(params[:address])

    if user.save
      redirect_to root_path
    else
      flash[:now] = "We couldn't assign you to a building!"
      render :inquire
    end
  end

  private

  def find_group(address_hash)
    Group.find_by(address_hash).id
  end

end
