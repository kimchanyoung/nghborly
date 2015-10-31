class VotesController < ApplicationController

    def create
        @vote = Vote.new(vote_params)
        @vote.voter_id = current_user.id
        if vote.save
            flash[:success] = "Thank you for your feedback!"
            redirect_to user_path(current_user)
        else
            flash[:now] = "Your vote has failed"
         end
    end

    private 

    def vote_params
        params.require(:vote).permit(:value)
    end 

    def find_candidate
        @vote.candidate_id = Vote.find(params[:vote][:candidate_id])
    end 
end


