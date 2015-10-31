class Event < ActiveRecord::Base
  belongs_to :request

  validates :type, inclusion: { in: ['request', 'response', 'fulfillment'] }
end
