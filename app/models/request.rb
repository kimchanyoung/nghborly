class Request < ActiveRecord::Base
  validates :content, presence: true
  validates :requester
  validates :isFulfilled, presence: true
end
