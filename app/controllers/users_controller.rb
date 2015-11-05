class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @transactions = Transaction.sort_by_user(@user)
  end
end