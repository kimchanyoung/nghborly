class User < ActiveRecord::Base
  belongs_to :group

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, :avatar, :uid, presence: true
  validates :uid, uniqueness: true
  validates :group
end
