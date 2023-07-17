require "rails_helper"

RSpec.describe Like do
	# Creo un utente e un post perché ne ho bisogno per poter creare un like.
	# Voglio verificare che il like sia creato con utente e post corretti.
	before do
		@user = User.create!(name: 'UserTest', email: 'ut@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456')
		@post = Post.create!(content: 'Il mio post di test', user_id: @user.id, tag: '#test')
		@like = Like.create!(user_id: @user.id, post_id: @post.id)
	end
	
	it "has a user" do
		# Verifico che il like sia stato correttamente creato con l'esatto user_id che ho passato.
		expect(@like.user_id).to eq(@user.id)
	end
	it "has a post" do
		# Verifico che il like sia stato correttamente creato con l'esatto post_id che ho passato.
		expect(@like.post_id).to eq(@post.id)
	end
	
end
