class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :age, :gender, :bio)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :current_password)
  end
end