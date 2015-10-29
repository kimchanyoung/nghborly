class Group < ActiveRecord::Base
  validates :name, :address, presence: true
end
