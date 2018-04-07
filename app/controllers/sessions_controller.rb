class SessionsController < ApplicationController
  def create
    if auth_hash.blank?
      if request['commit'] == 'Register'
        registration
      else
        authorization
      end
    else
      @user = User.find_or_create_from_auth_hash(auth_hash)
    end
    if @user.blank?
      flash[:danger] = 'Invalid login or password'
    else
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'Sucessfully logged out!'
    end
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def index
    @user = User.new
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :id)
  end

  def authorization
    @user = User.where(email: user_params[:email].to_s)
    @user = @user.where(password: user_params[:password].to_s).first
  end

  def registration
    @user = User.new(user_params)
    @user.name = user_params[:email]
    @user.save
  end
end
