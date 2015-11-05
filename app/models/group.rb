class Group < ActiveRecord::Base
  has_many :users
  has_many :requests

  validates :primary_number, :street_name, :city_name, :state_abbreviation,
            :zipcode, presence: true

  def name
    "#{primary_number} #{street_predirection} #{street_name} #{street_suffix}"
  end

end
