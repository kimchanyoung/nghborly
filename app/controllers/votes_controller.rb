<<<<<<< HEAD
class VotesController < UserActionsController
=======
class VotesController < ApplicationController

    def new
        @vote = Vote.new
        @user = User.find_by(id: params[:user_id])
    end

>>>>>>> Add new method for initializing a vote and finding a user
    def create
    end
end
