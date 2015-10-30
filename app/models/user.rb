class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, :avatar, :uid, presence: true
  validates :uid, uniqueness: true
  validates :group_id, presence: true, numericality: { only_integer: true }
end
