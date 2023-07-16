class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #modifica canzone preferita
  def search
    RSpotify.authenticate("d654966e96084bcdb7ec9a296fa0b0a1", "f271efc1b16c404f9ee71c318baa581a")

    query = params[:search_query]

    # Cerca una canzone
    track = RSpotify::Track.search(query, limit: 1).first

    if track
      @nome_canzone = track.name + " by " + track.artists.first.name
      if user_signed_in?
        current_user.update(song: @nome_canzone)
      end 
    else
      @nome_canzone = "Nessuna canzone trovata."
    end
    puts @nome_canzone
    #flash[@nome_canzone]
    session[:canzone] = @nome_canzone
    redirect_to user_path(current_user.id)
  end

  #scopri artista preferita dal periodo
  def user_artist
    RSpotify.authenticate("d654966e96084bcdb7ec9a296fa0b0a1", "f271efc1b16c404f9ee71c318baa581a")
  
    user = RSpotify::User.new(session[:spotify_access_token])
    top_artists = user.top_artists(limit: 1, time_range: 'medium_term')
    most_listened_artist = top_artists.first

    most_listened_artist_name = most_listened_artist.name
    if user_signed_in?
      current_user.update(mostlistenedartist: most_listened_artist_name)
    end
    session[:artista] = most_listened_artist_name
    redirect_to user_path(current_user.id)
  end

  #scopri canzone più ascoltata del momento
  def user_song
    RSpotify.authenticate("d654966e96084bcdb7ec9a296fa0b0a1", "f271efc1b16c404f9ee71c318baa581a")
  
    user = RSpotify::User.new(session[:spotify_access_token])
    top_tracks = user.top_tracks(limit: 1, time_range: 'medium_term')
    most_listened_song = top_tracks.first

    most_listened_song_name = most_listened_song.name
    if user_signed_in?
      current_user.update(mostlistenedsong: most_listened_song_name)
    end
    session[:fcanzone] = most_listened_song_name
    redirect_to user_path(current_user.id)
  end

  #crea playlist basandosi sulla 
  def create_recommended_playlist
    RSpotify.authenticate("d654966e96084bcdb7ec9a296fa0b0a1", "f271efc1b16c404f9ee71c318baa581a")
  
    user = RSpotify::User.new(session[:spotify_access_token])
    top_track = user.top_tracks(limit: 1, time_range: 'short_term')
    top_track_id = top_track.first.id

    favourite_track = RSpotify::Track.search(current_user.song, limit: 1).first
    favourite_track_id = favourite_track.id

    recommendations = RSpotify::Recommendations.generate(seed_tracks: [top_track_id, favourite_track_id],limit: 10)

    recommended_tracks = recommendations.tracks

    playlist = user.create_playlist!('Spotiforum Recommended Playlist!')

    playlist.add_tracks!(recommended_tracks)

    redirect_to user_path(current_user.id), notice: 'Playlist consigliata creata con successo!'
  end

  #crea playlist con canzoni scelte dall'autore
  def create_your_own_playlist
    RSpotify.authenticate("d654966e96084bcdb7ec9a296fa0b0a1", "f271efc1b16c404f9ee71c318baa581a")
  
    user = RSpotify::User.new(session[:spotify_access_token])
    
    #prendo i parametri dalla post
    queries = (1..5).map { |i| params["search_query#{i}"] }

    # Cerca le canzon1
    tracks = []
    queries.each do |query|
        track = RSpotify::Track.search(query, limit: 1).first
        if track
            tracks.append(track)
        end
    end
  
    #creazione playlist
    playlist = user.create_playlist!('Your Spotiforum Playlist!')

    playlist.add_tracks!(tracks)

    redirect_to user_path(current_user.id), notice: 'Playlist consigliata creata con successo!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :photo, :spotify, :song, :google, :password, :mostlistenedsong, :mostlistenedartist)
    end
end
