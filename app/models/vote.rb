class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: 'User'
  belongs_to :candidate, class_name: 'User'

  validates :voter, :candidate
  validates :value, presence: true, inclusion: { in: [1, -1] }
end
