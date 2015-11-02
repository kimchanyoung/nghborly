class Vote < ActiveRecord::Base
  after_save :update_parent_vote_total
  belongs_to :candidate, class_name: 'User', foreign_key: 'candidate_id'

  validates :candidate, uniqueness: { scope: :request }
  validates :value, inclusion: { in: [1, -1] }

  def update_parent_vote_total
    User.find(self.request_id).count_votes
  end
end
