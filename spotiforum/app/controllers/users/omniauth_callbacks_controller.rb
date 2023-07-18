# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def google_oauth2
    @user = User.from_omniauthGoogle(request.env['omniauth.auth'])
    
    if @user.present?
      #sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      #lash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      #redirect_to new_user_session_path
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
    end

  def spotify
    data = request.env["omniauth.auth"].info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(email: data['email'],
          name: data['name'],
          password: Devise.friendly_token[0,20],
          google: false,
          spotify: true
      )
    end

    @user = user

    session[:spotify_access_token] = request.env['omniauth.auth']
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.spotify_data"] = request.env["omniauth.auth"] #.extra['raw_info']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to pages_community_path
  end


  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  #def passthru
  #  super
  #end

  # GET|POST /users/auth/twitter/callback
  #def failure
  #  super
  #end

  #protected

  # The path used when OmniAuth fails
  #def after_omniauth_failure_path_for(scope)
  #  super(scope)
  #end

  def auth
    @auth ||=request.env['omniauth.auth']
  end
end
