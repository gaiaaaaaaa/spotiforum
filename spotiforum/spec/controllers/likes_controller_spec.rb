require "rails_helper"

RSpec.describe LikesController, type: :controller do
	describe "POST create" do
		# Creo l'utente che metterà like al post e il post stesso, per verificare che tutto vada correttamente.
		before do
			@user1 = User.create!(name: 'Utente1', email: 'u1@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456')
			@user2 = User.create!(name: 'Utente2', email: 'u2@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456')
			@post1 = Post.create!(content: 'Post', user_id: @user1.id, tag: '#1')
			@like1 = Like.create!(user_id: @user1.id, post_id: @post1.id)
		end
		
		it "creates a new like" do
			# Per creare un nuovo like faccio una post per chiamare l'azione create del likes_controller.rb.
			expect {
				# Controllo che la chiamata all'azione Create del controller dei Likes aumenti effettivamente
				# di 1 il count dei likes totali.
				post :create, params: { like: {user_id: @user2.id, post_id: @post1.id } }
			}.to change(Like, :count).by(1)
		end
		it "doesn't allow liking the same post two times" do
			expect {
				# Controllo che la chiamata all'azione Create del controller dei Likes non aumenti il numero
				# dei like, poiché sto provando a creare un nuovo like con lo stesso utente e sullo stesso post
				# di quello creato all'inizio nella sezione before.
				post :create, params: {like: {user_id: @user1.id, post_id: @post1.id } }
			}.to change(Like, :count).by(0)
		end
	end
end
