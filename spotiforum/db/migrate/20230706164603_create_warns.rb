class CreateWarns < ActiveRecord::Migration[6.1]
  def change
    create_table :warns do |t|
      t.integer :user_id
      t.integer :administrator_id

      t.timestamps
    end
  end
end
