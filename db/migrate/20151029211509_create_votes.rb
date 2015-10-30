class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id, null: false
      t.integer :candidate_id, null: false
      t.integer :value, null: false

      t.timestamps null: false
    end
  end
end
