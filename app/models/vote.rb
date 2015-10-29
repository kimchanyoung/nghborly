class Vote < ActiveRecord::Base
  validates :voter_id, :candidate_id, presence: true, numericality: { only_integer: true }
  validates :value, presence: true, inclusion: { in: [1, -1] }
end
