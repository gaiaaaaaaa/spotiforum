class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.string :tag

      t.timestamps
    end
  end
end
