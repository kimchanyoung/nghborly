class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :number,   null: false
      t.string  :street,   null: false
      t.string  :city,     null: false
      t.string :zip_code, null: false

      t.timestamps null: false
    end
  end
end
