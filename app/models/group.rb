class Group < ActiveRecord::Base
  has_many :users
  has_many :requests

  validates :primary_number, :street_name, :street_suffix, :city_name,
            :state_abbreviation, :zipcode, presence: true

  def name
    "#{primary_number} #{street_name} #{street_suffix}"
  end

end
