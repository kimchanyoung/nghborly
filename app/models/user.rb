class User < ActiveRecord::Base
  belongs_to :group
  has_many :made_requests, class_name: 'Request', foreign_key: 'requester_id'
  has_many :fulfilled_requests, class_name: 'Request', foreign_key: 'responder_id'
  has_many :votes, as: :voter
  has_many :votes, as: :candidate

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :group, presence: true
end
