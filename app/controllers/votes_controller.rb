class VotesController < ApplicationController

    def create
        @vote = Vote.new(vote_params)
        @vote.candidate_id = other_party_of(Request.find(request_id))
        if vote.save
            flash[:success] = "Thank you for your feedback!"
            redirect_to user_path(current_user)
        else
            flash[:now] = "Your vote has failed"
        end
    end

    def other_party_of(request)
    if current_user == request.requester
      request.responder
    elsif current_user == request.responder
      request.requester
    end
end

    private 

    def vote_params
        params.require(:vote).permit(:value, :request_id)
    end 

    def find_candidate
        @vote.candidate_id = Vote.find_by(params[:vote][:candidate_id])
    end 
end


