# Allows full CRUD operations for a user.
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy validate]
  before_action :ensure_logged_in, only: %i[edit update destroy]

  def show
    user_events = UserEvent.where(user_id: params[:id]).map(&:event_id).uniq
    @events = Event.where(id: user_events)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      SignupMailer.new_user(@user).deliver_now
      login(@user)
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @user.valid?
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
    end
  end

  def destroy
    User.destroy(current_user.id)
    redirect_to new_user_path
  end

  def validate
    if @user
      @user.update(validated: true)
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end

end
