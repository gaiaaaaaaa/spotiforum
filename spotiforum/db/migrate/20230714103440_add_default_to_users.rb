class AddDefaultToUsers < ActiveRecord::Migration[6.1]
  def change
	change_column_default :users, :google, from: nil, to: false
	change_column_default :users, :spotify, from: nil, to: false
  end
end
