class Transaction < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  after_create :trigger_message

  belongs_to :request

  validates :transaction_type, inclusion: { in: ['request', 'response', 'fulfillment'] }

  def self.sort_by_group(group)
    Transaction.joins(:request).where(requests: {group_id: group.id})
  end

  def self.sort_by_user(user)
    Transaction.joins(:request).where('requests.requester_id = ? OR requests.responder_id = ?', user.id, user.id)
  end

  def self.sort_by_active
    Transaction.joins(:request).where('transaction_type LIKE :type AND transactions.created_at BETWEEN :then AND :now', type: 'request', then: 1.hour.ago, now: Time.now).where(requests: {is_fulfilled: false})
  end

  def pretty_date
    time_ago_in_words(created_at)
  end

  def trigger_message
    request_obj = self.request

    case self.transaction_type
    when "request"
      trigger_request_message(request_obj)
    when "response"
      trigger_response_message(request_obj)
    when "fulfillment"
      trigger_fulfillment_message(request_obj)
    end
  end

  def trigger_request_message(request)
    Pusher["presence-#{request.group.id}"].trigger('new_transaction', {
      type: self.transaction_type,
      src: request.requester.picture,
      request_text: request_text,
      requester_link: "/users/#{request.requester.id}",
      requester_first_name: request.requester.first_name,
      time: pretty_date
    })
  end

  def trigger_response_message(request)
  end

  def trigger_fulfillment_message(request)
  end

  def request_text
    ['cried out for help',
     'sent an SOS',
     'made a request',
     'shouted for aid',
     'sent out a smoke signal',
     'pinged neighbors',
     'lit the beacons'].sample
  end
end
