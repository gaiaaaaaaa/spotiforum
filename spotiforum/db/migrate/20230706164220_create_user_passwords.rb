class CreateUserPasswords < ActiveRecord::Migration[6.1]
  def change
    create_table :user_passwords do |t|
      t.string :password
      t.integer :salt
      t.integer :user_id
      t.timestamps
    end
  end
end
