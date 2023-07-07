class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :photo
      t.boolean :spotify
      t.string :song

      t.timestamps
    end
  end
end
