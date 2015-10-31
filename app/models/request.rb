class Request < ActiveRecord::Base
  before_save :defaultly_unfulfilled

  belongs_to :requester, class_name: 'User'
  belongs_to :responder, class_name: 'User'

  validates :content, presence: true
  validates :requester, presence: true
  validates :isFulfilled, presence: true

  private
  def defaultly_unfulfilled
    self.isFulfilled || = false
  end
end
