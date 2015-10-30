class Group < ActiveRecord::Base
  has_many :users

  validates :name, :address, presence: true, uniqueness: true
end
