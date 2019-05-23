class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login(@user)
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username)
  end

end
