class Request < ActiveRecord::Base
  belongs_to :requester, class_name: 'User'
  belongs_to :responder, class_name: 'User'

  validates :content, presence: true
  validates :requester, presence: true
  validates :isFulfilled, presence: true
end
