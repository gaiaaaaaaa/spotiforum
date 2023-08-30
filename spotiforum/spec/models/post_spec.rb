require "rails_helper"

RSpec.describe Post do
	subject { described_class.new }
	context 'Attributes' do
		context 'tag' do
			it 'should have a tag attribute' do
				expect(subject).to respond_to(:tag)
			end
			it 'should be invalid without a tag' do
				subject.tag = nil
				expect(subject).to be_invalid
			end
			it 'should have a correct format' do
				subject.tag = "#tag1#tag2"
				expect(subject).to be_invalid

				subject.tag = "#tag1 #tag,2"
				expect(subject).to be_invalid
			end
		end

		context 'content' do
			it 'should have a content attribute' do
				expect(subject).to respond_to(:content)
			end
			it 'should be invalid without a content' do
				subject.content = nil
				expect(subject).to be_invalid
			end
			it 'should have a correct format' do
				subject.content = "a"*282
				expect(subject).to be_invalid

				subject.content = "a"*3
				expect(subject).to be_invalid
			end
		end

		context 'user_id' do
			it 'should have a user_id attribute' do
				expect(subject).to respond_to(:user_id)
			end
			it 'should be invalid without a user_id' do
				subject.user_id = nil
				expect(subject).to be_invalid
			end
		end
	end

	# Creo un utente e un post perché voglio testare che i post vengano creati correttamente.
	# Voglio che il post abbia l'id di un utente e non un numero magico.
	before do
		@user = User.create!(name: 'UserTest', email: 'ut@mail.com', spotify: false, song: nil, google: false, password: '123456')
		@post = Post.create!(content: 'Il mio post di test', user_id: @user.id, tag: '#test')
	end
	it "has a content" do
		# Verifico che il post sia stato correttamente creato con l'esatto contenuto che ho passato.
		expect(@post.content).to eq('Il mio post di test')
	end
	it "has a user_id" do
		# Verifico che l'id del creatore del post corrisponda con quello dell'utente che lo ha effettivamente
		# creato.
		expect(@post.user_id).to eq(@user.id)
	end
end
