class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :photo
      t.boolean :spotify
      t.string :song

      t.timestamps

      validates_uniqueness_of :name
      validates_uniqueness_of :email
      add_check_constraint "spotify_check", "!(spotify ==false and song!='')"
    end
  end
end
