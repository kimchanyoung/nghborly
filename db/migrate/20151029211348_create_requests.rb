class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :content, null: false
      t.integer :requester_id, null: false
      t.integer :responder_id
      t.integer :group_id, null: false
      t.boolean :is_fulfilled, default: false

      t.timestamps null: false
    end
  end
end
