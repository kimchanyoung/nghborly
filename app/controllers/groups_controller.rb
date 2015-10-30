class GroupsController < ApplicationController
  def assign
    user = current_user

    group_id = find_group(params[:address])

    user.group_id = group_id
  end

  private

  def find_group(address_hash)
    Group.where(address_hash).pluck(id)
  end

end
