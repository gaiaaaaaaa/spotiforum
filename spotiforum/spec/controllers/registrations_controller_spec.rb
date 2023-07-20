require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :controller do
    include Devise::Test::ControllerHelpers

	#describe "PUT update" do
		# Creo l'utente da modificare per verificare che non cambino i campi spotify, google e admin.
	#	before do
	#		@user = User.create!(name: 'Utente', email: 'u@mail.com', photo: 1, spotify: false, song: nil, google: false, password: '123456')

	#		sign_in @user
	#	end
		
	#	it "updates the user's name" do
    #        put :update, params: { user: { name: 'newname', email: 'u@mail.com', current_password: '123456' } }
    #        @user.reload
	#		expect(@user.name).to eq("newname")	
	#	end
	#end
end
