class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :sender, class_name: 'User'

  validates :content, :request, :sender, presence: true
end
