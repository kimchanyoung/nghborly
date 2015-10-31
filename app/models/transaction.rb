class Transaction < ActiveRecord::Base
  belongs_to :request

  validates :transaction_type, inclusion: { in: ['request', 'response', 'fulfillment'] }

  def self.sort_by_group(group)
    Transaction.where(request: Request.joins(:requester).where(users: {group_id: group.id}))
  end

  def self.sort_by_user(user)
    Transaction.joins(:request).where(requests: {requester_id: user.id})
  end

  def self.sort_by_active
    Transaction.joins(:request).where('transaction_type LIKE :type AND transactions.created_at BETWEEN :then AND :now', type: 'request', then: 1.hour.ago, now: Time.now).where(requests: {is_fulfilled: false})
  end
end