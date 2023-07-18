class DropAdministrators < ActiveRecord::Migration[6.1]
  def change
	drop_table :administrators
  end
end
