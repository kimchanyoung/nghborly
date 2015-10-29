class Request < ActiveRecord::Base
  validates :content presence: true
  validates :requester_id, :responder_id, presence: true, numericality: { only_integer: true }
  validates :isFulfilled, presence: true
end
