require "rails_helper"

RSpec.describe LikesController, type: :controller do
	describe "POST create" do
		# Creo l'utente che metterà like al post e il post stesso, per verificare che tutto vada correttamente.
		let(:user1) { User.create!(name: 'Utente1', email: 'u1@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456') }
		let(:user2) { User.create!(name: 'Utente2', email: 'u2@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456') }
		let(:post1) { Post.create!(content: 'Post', user_id: user1.id, tag: '#1') }
		let(:like1) { Like.create!(user_id: user1.id, post_id: post1.id) }
		
		it "creates a new like" do
			# Per creare un nuovo like faccio una post per chiamare l'azione create del likes_controller.rb.
			expect {
				post :create, params: { like: {user_id: user2.id, post_id: post1.id } }
			}.to change(Like, :count).by(1)
		end
	end
end
