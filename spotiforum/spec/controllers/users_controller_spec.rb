require "rails_helper"

RSpec.describe UsersController, type: :controller do
    describe "POST search" do
        before do
            @user = User.create!(name:"spotiuser", email: "spotiuser@mail.com", spotify: true, song: nil, password: "123456", spotify_username:"spotiUser")
            sign_in @user
            allow(controller).to receive(:current_user).and_return(@user)
		end

        it 'looks for a song' do
            post :search, params: { search_query: "Hello" }
            expect(@user.song).to eq("Hello by Adele")
        end
    end


end
