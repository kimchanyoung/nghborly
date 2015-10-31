class Request < ActiveRecord::Base
  before_create :defaultly_unfulfilled

  belongs_to :requester, class_name: 'User'
  belongs_to :responder, class_name: 'User'

  validates :content, presence: true
  validates :requester, presence: true
  validates :is_fulfilled, inclusion: { in: [true, false] }

  private
  def defaultly_unfulfilled
    self.is_fulfilled = false
    true
  end
end
