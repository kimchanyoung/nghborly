class User < ActiveRecord::Base
  belongs_to :group
  has_many :requests, as: :requester
  has_many :requests, as: :responder
  has_many :votes, as: :voter
  has_many :votes, as: :candidate

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :group, presence: true
end
