require "rails_helper"

RSpec.describe Post do
	# Creo un utente e un post perché voglio testare che i post vengano creati correttamente.
	# Voglio che il post abbia l'id di un utente e non un numero magico.
	let(:user) { User.create!(name: 'UserTest', email: 'ut@mail.com', photo: 1, spotify: false, song: '', google: false, encrypted_password: '123456') }
	let(:post) { Post.create!(content: 'Il mio post di test', user_id: user.id, tag: '#test') }
	it "has a content" do
		# Verifico che il post sia stato correttamente creato con l'esatto contenuto che ho passato.
		expect(post.content).to eq('Il mio post di test')
	end
	it "has a user_id" do
		# Verifico che l'id del creatore del post corrisponda con quello dell'utente che lo ha effettivamente
		# creato.
		expect(post.user_id).to eq(user.id)
	end
end
