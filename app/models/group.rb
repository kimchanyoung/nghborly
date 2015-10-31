class Group < ActiveRecord::Base
  has_many :users

  validates :street, :city, :number, :zip_code, presence: true

  def name
    "#{number} #{street}"
  end

end
