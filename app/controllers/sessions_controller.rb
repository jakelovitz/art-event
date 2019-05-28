# Controller that handles login and logout status.
# A User can either be logged in or logged out.
# Only controller actions concerned with creating and destroying a session
# are defined.
class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_credentials(params[:email], params[:password])
    if @user
      login(@user)
      redirect_to user_path(@user)
    else
      flash.now[:errors] = ['Invalid Email or Password']
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end
end
