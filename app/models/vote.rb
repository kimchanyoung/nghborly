class Vote < ActiveRecord::Base
  belongs_to :candidate, class_name: 'User'
  belongs_to :request

  validates :candidate, uniqueness: { scope: :request }
  validates :value, inclusion: { in: [1, -1] }
end
