class VotesController < UserActionsController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      @vote.candidate.update_vote_total
      flash[:success] = "Thank you for your feedback!"
      redirect_to root_path
    else
      flash[:now] = "Your vote has failed"
      render 'requests/show.html.erb'
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
    @request = Request.find_by(id: params[:request_id])
    @candidate = other_party_of(@request)

    known_attrs = { request_id: @request.id, candidate_id: @candidate.id }

    params.require(:vote).permit(:value).merge(known_attrs)
  end
end
