class Vote < ActiveRecord::Base
    after_save :update_parent_vote_total 
    
    belongs_to :voter, class_name: 'User'
    belongs_to :candidate, class_name: 'User'

  validates :voter, :candidate, presence: true
  validates :value, presence: true, inclusion: { in: [1, -1] }
  validates :candidate_id, uniqueness: {scope: :request_id}

  def update_parent_vote_total
    if self.voter == "User"
        User.find(self.voter_id).count_votes
    end
end
end
