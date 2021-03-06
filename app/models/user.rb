class User < ActiveRecord::Base
  belongs_to :group
  has_many   :made_requests, class_name: 'Request', foreign_key: 'requester_id'
  has_many   :fulfilled_requests, class_name: 'Request', foreign_key: 'responder_id'
  has_many   :votes, foreign_key: 'candidate_id'

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def requests_in_last_24_hours
    conditions = { requester_id: id, created_at: (Time.now - 1.day..Time.now) }
    Request.where(conditions).count
  end

  def update_vote_total
    update(vote_count: self.votes.sum(:value))
  end
end
