class Vote < ActiveRecord::Base
    after_save :update_parent_vote_total 
    
    belongs_to :candidate, class_name: 'User'

  validates :candidate, presence: true
  validates :value, presence: true, inclusion: { in: [1, -1] }
  validates :candidate_id, uniqueness: {scope: :request_id}

  def update_parent_vote_total
        User.find(self.request_id).count_votes
    end
end
