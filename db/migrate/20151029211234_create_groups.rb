class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :primary_number,     null: false
      t.string  :street_name,        null: false
      t.string  :street_suffix
      t.string  :city_name,          null: false
      t.string  :state_abbreviation, null: false
      t.string  :zipcode,            null: false

      t.timestamps null: false
    end
  end
end
