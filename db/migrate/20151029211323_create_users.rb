class CreateUsers < ActiveRecord::Migration
  def change
  create_table :users do |t|
      t.string :user_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :group_id
      t.integer :vote_count, null: false, default: 0
      t.string :picture, default: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"

      t.timestamps null: false
    end
  end
end
