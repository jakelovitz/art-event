class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Methods to be used in views
  helper_method :current_user, :logged_in?, :ensure_validated

  # @return [User] or [nil]
  # Retrieves the current user based on their session token if
  # none is found returns nil
  def current_user
    User.find_by(session_token: session[:session_token])
  end

  # Redirects to login screen unless already logged in.
  def ensure_logged_in
    redirect_to new_session_path unless logged_in?
  end

  # @return [boolean]
  # coerce current_user into true or false
  def logged_in?
    !!current_user
  end

  # Logs in the user
  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  # Changes the current_user session_token in the db.
  # Sets rails session to nil.
  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def validated?
    current_user.validated
  end

  def ensure_validated
    flash[:validation] = 'Please validate you own your email address.'
    redirect_to home_path unless validated?
  end

end
