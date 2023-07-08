class CreateAdministratorPasswords < ActiveRecord::Migration[6.1]
  def change
    create_table :administrator_passwords do |t|
      t.string :password
      t.integer :salt
      t.integer :administrator_id
      t.timestamps
    end
  end
end
