class Request < ActiveRecord::Base
  before_create :defaultly_unfulfilled

  has_many :messages
  has_many :transactions
  has_many :votes

  belongs_to :requester, class_name: 'User'
  belongs_to :responder, class_name: 'User'
  belongs_to :group

  validates :content, :requester, :group, presence: true
  validates :is_fulfilled, inclusion: { in: [true, false] }

  def active?
    responder.nil? && (Time.now - created_at) <= 2700 && !is_fulfilled
  end

  def can_view?(user)
    if responder.nil?
      user.group == group
    else
      is_party_to?(user)
    end
  end

  def is_party_to?(user)
    [requester.id, responder.id].include?(user.id)
  end

  def pretty_date
    time_ago_in_words(created_at)
  end

  private

  def defaultly_unfulfilled
    self.is_fulfilled = false
    true
  end
end
