class AddUserIdToUserPasswords < ActiveRecord::Migration[6.1]
  def change
    add_column :user_passwords, :user_id, :integer
  end
end
