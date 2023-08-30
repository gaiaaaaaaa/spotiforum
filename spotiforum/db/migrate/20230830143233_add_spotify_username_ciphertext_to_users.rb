class AddSpotifyUsernameCiphertextToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :spotify_username_ciphertext, :text
  end
end
