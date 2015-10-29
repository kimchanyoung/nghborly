class User < ActiveRecord::Base
  validates :first_name, :last_name, :password_digest, presence: true
  validates :email, presence: true, uniqueness: true
  validates :group_id, presence: true, numericality: { only_integer: true }
end
