class Group < ActiveRecord::Base
  has_many :users

  validates :street, :city, presence: true
  validates :number, :zip_code,  numericality: { only_integer: true }

  def name
    "#{number} #{street}"
  end

end
