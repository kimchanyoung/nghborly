class CreateUsers < ActiveRecord::Migration
  def change
  create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :group_id
      t.integer :vote_count, null: false, default: 0
      t.string :picture, default: "http://www.gravatar.com/avatar/?s=60&d=identicon"

      t.timestamps null: false
    end
  end
end
