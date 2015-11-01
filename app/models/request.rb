class Request < ActiveRecord::Base
  before_create :defaultly_unfulfilled

  has_many :messages
  has_many :transactions

  belongs_to :requester, class_name: 'User'
  belongs_to :responder, class_name: 'User'
  belongs_to :group

  validates :content, :requester, :group, presence: true
  validates :is_fulfilled, inclusion: { in: [true, false] }

  def active?
    # placeholder, must put logic here
    true
  end

  def can_view?(user)
    if responder.nil?
      current_user.group == group
    else
      is_party_to?(user)
    end
  end

  def is_party_to?(user)
    [requester.id, responder.id].include?(user.id)
  end

  private

  def defaultly_unfulfilled
    self.is_fulfilled = false
    true
  end
end
