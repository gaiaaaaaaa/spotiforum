require "rails_helper"

RSpec.describe User do
	# Creo un utente perché voglio testare che venga creato correttamente.
	before do
		@user = User.create!(name: 'UserTest', email: 'ut@mail.com', spotify: false, google: false, password: '123456')
		@userspotify = User.create!(name: 'spotiUser', email: 'spotiuser@mail.com', spotify: true, google: false, password: '123456', spotify_username:'spotiuser')
	end
	
	it "has a name" do
		# Verifico che l'utente sia stato correttamente creato con l'esatto nome che ho passato.
		expect(@user.name).to eq('UserTest')
	end
	it "has a email" do
		# Verifico che l'utente sia stato correttamente creato con l'esatta email che ho passato.
		expect(@user.email).to eq('ut@mail.com')
	end
	it "has not spotify" do
		# Verifico che l'utente sia stato correttamente creato senza l'utilizzo di spotify.
		expect(@user.spotify).to eq(false)
	end
	it "has not a song" do
		# Verifico che l'utente sia stato correttamente creato senza una canzone preferita.
		expect(@user.song).to eq(nil)
	end
	it "has not a most listened song" do
		# Verifico che l'utente sia stato correttamente creato senza una canzone preferita.
		expect(@user.mostlistenedsong).to eq(nil)
	end
	it "has not a most listened artist" do
		# Verifico che l'utente sia stato correttamente creato senza una canzone preferita.
		expect(@user.mostlistenedartist).to eq(nil)
	end
	it "has not google" do
		# Verifico che l'utente sia stato correttamente creato senza l'utilizzo di google.
		expect(@user.google).to eq(false)
	end
	it "has a password" do
		# Verifico che l'utente sia stato correttamente creato con la password che ho passato.
		expect(@user.password).to eq('123456')
	end
	it "is not an admin" do
		# Verifico che l'utente sia stato correttamente creato con la password che ho passato.
		expect(@user.admin).to eq(false)
	end

	#verifico che l'update di search song funzioni correttamente
	it 'changes song' do
		@userspotify.update!(song: "Hello")
		expect(@userspotify.song).to eq("Hello")
	end

	it 'does not change google because it is spotify user' do
		@userspotify.update(google: true)
		expect(@userspotify).to be_invalid
	end
end
