class UsersController < ApplicationController
  before_action :ensure_admin
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.password.blank?
      temp_password = SecureRandom.hex(8)
      @user.password = temp_password
      @user.password_confirmation = temp_password
    end
    
    if @user.save
      notice_msg = @user.password.blank? ? "Usuario creado exitosamente." : "Usuario creado. Contraseña temporal: #{temp_password}"
      redirect_to users_path, notice: notice_msg
    else
      render :new
    end
  end

  def edit
  end

  def update
    user_params_update = user_params
    user_params_update = user_params_update.except(:password, :password_confirmation) if user_params_update[:password].blank?
    
    if @user.update(user_params_update)
      redirect_to users_path, notice: 'Usuario actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'Usuario eliminado exitosamente.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end

  def ensure_admin
    redirect_to root_path, alert: 'Acceso denegado.' unless current_user&.admin?
  end
end