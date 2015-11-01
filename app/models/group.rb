class Group < ActiveRecord::Base
  has_many :users
  has_many :requests

  validates :street, :city, :number, :zip_code, presence: true

  def name
    "#{number} #{street}"
  end

end
