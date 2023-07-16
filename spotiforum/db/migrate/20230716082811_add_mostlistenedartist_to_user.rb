class AddMostlistenedartistToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mostlistenedartist, :string
  end
end
