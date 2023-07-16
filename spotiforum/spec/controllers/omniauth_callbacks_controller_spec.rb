require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  # Ho bisogno del modulo per fare i test su Devise
  include Devise::Test::ControllerHelpers
  
  describe 'GET #google_oauth2' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    
    it 'creates a new user with Google OAuth' do
      expect {
        # Voglio verificare che questa chiamata crei un nuovo utente nel database.
        get :google_oauth2
        # Controllo che ciò avvenga vedendo se il numero di utenti sia aumentato di uno.
      }.to change(User, :count).by(1)
      
      # Voglio che la risposta alla chiamata mi indirizzi alla radice.
      expect(response).to redirect_to(root_path)
      # Verifico la presenza del messaggio di successo.
      expect(flash[:success]).to be_present
      # Verifico che l'utente sia stato autenticato e sia diventato l'utente corrente.
      expect(controller.current_user).to be_present
    end
  end
  
  describe 'GET #spotify' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:spotify]
    end
    
    it 'creates a new user with Spotify OAuth' do
      expect {
        get :spotify
      }.to change(User, :count).by(1)
      
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to be_present
      expect(controller.current_user).to be_present
    end
  end
  
end
