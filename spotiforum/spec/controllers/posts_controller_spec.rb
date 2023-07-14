require "rails_helper"

RSpec.describe PostsController, type: :controller do
	describe "GET index" do
		# Creo inizialmente la struttura di cui ho bisogno: diversi utenti, post creati dai rispettivi
		# utenti e like messi dagli utenti stessi.

		# 2 utenti diversi, non mi interessano dei valori significativi ma devo rispettare i vincoli
		# delle validazioni.
		let(:user1) { User.create!(name: 'Jake', email: 'j@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456') }
		let(:user2) { User.create!(name: 'Lisa', email: 'l@mail.com', photo: 1, spotify: false, song: nil, google: false, encrypted_password: '123456') }
		# 3 post creati in istanti di tempo diversi, 2 dal primo utente, 1 dal secondo utente.
		let(:post1) { Post.create!(content: 'Post 1', user_id: user1.id, tag: '#1', created_at: 4.days.ago) }
		let(:post2) { Post.create!(content: 'Post 2', user_id: user1.id, tag: '#2', created_at: 2.days.ago) }
		let(:post3) { Post.create!(content: 'Post 3', user_id: user2.id, tag: '#3', created_at: Time.now) }
		# 3 like, in modo che un post abbia 2 like, uno ne abbia 1 e uno non ne abbia alcuno.
		let(:like1) { Like.create!(post_id: post1.id, user_id: user1.id) }
		let(:like2) { Like.create!(post_id: post1.id, user_id: user2.id) }
		let(:like3) { Like.create!(post_id: post3.id, user_id: user1.id) }

		it 'orders posts by most recent' do
			# Quando ordino i post per avere in cima i più recenti, seleziono un radiobutton in un form che,
			# una volta inviato, esegue una get sull'azione index passando come parametro params[:sort_by]
			# 'created_at_desc'. Il controller ordina quindi i post dal più recente, infatti prende i post in
			# base alla data di creazione decrescente.
			get :index, params: {sort_by: 'created_at_desc' }
			# A questo punto mi aspetto che i post siano ordinati dal più recente al meno recente:
			# dato che @post1 è stato creato 4 giorni fa, @post2 è stato creato 2 giorni fa e @post3
			# è stato creato adesso, mi aspetto in uscita [@post3, @post2, @post1].
			# Per verificarlo, prendo la variabile @posts aggiornata dal controller.
			expect(controller.instance_variable_get(:@posts)).to eq([post3, post2, post1])
		end
		it 'orders posts by least recent' do
			# Quando ordino i post per avere in cima i meno recenti, seleziono un radiobutton in un form che,
			# una volta inviato, esegue una get sull'azione index passando come parametro params[:sort_by]
			# 'created_at'. Il controller ordina quindi i post dal meno recente., infatti prende i post in
			# base alla data di creazione crescente.
			get :index, params: { sort_by: 'created_at' }
			# A questo punto mi aspetto che i post siano ordinati dal meno recente al più recente:
			# dato che @post1 è stato creato 4 giorni fa, @post2 è stato creato 2 giorni fa e @post3
			# è stato creato adesso, mi aspetto in uscita [@post1, @post2, @post3].
			# Per verificarlo, prendo la variabile @posts aggiornata dal controller.
			expect(controller.instance_variable_get(:@posts)).to eq([post1, post2, post3])
		end
		it 'orders posts by likes' do
			# Quando ordino i post per avere in cima quelli con un numero maggiore di mi piace, seleziono un 
			# radiobutton in un form che, una volta inviato, esegue una get sull'azione index passando come 
			# parametro params[:sort_by] 'likes'. Il controller ordina quindi i post dal più piaciuto.
			get :index, params: { sort_by: 'likes' }
			# A questo punto mi aspetto che i post siano ordinati dal più popolare al meno popolare:
			# dato che @post1 ha ricevuto 2 mi piace, @post3 ha ricevuto 1 mi piace e @post2
			# non ha ricevuto mi piace, mi aspetto in uscita [@post1, @post3, @post2].
			# Per verificarlo, prendo la variabile @posts aggiornata dal controller.
			expect(controller.instance_variable_get(:@posts)).to eq([post1, post3, post2])
		end
	end
end
