class SessionsController < ApplicationController

  def new
    redirect_to '/auth/github'
  end

  #extract provider name e.g. github  and the unique id of the user of this provider
  #if there is no user with this params, it will create a new user using the create_with_omniauth mothod
  #in user model
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
