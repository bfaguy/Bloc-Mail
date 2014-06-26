class RegistrationsController < Devise::RegistrationsController

  def new
    flash[:alert] = 'Registrations is not available at this time'
    redirect_to root_path
  end

  def create
    flash[:alert] = 'Registrations is not available at this time'
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
