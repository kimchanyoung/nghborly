class Transaction < ActiveRecord::Base
  belongs_to :request

  validates :transaction_type, inclusion: { in: ['request', 'response', 'fulfillment'] }

  def self.sort_by_group(group)
    @transactions = Transaction.where(request: Request.joins(:requester).where(users: {group_id: group.id}))
    render 'transactions/index.html.erb'
  end

  def self.sort_by_user(user)
    @transactions = Transaction.joins(:request).where(requests: {requester_id: user_id})
    render 'transactions/index.html.erb'
  end

  def self.sort_by_active
    @transactions = Transaction.joins(:request).where('transaction_type LIKE :type AND transactions.created_at BETWEEN :then AND :now', type: 'request', then: 1.hour.ago, now: Time.now).where(requests: {is_fulfilled: false})
    render 'transactions/index.html.erb'
  end
end