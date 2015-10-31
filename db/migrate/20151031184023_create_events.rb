class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :request_id, null: false
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
