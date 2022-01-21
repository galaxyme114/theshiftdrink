class Admin::AccountController < Admin::BaseController
  
  # => GET /account
  def index
  end

  # => PATCH /account/profile
  def profile
    if current_user.update(profile_params)
      redirect_to account_settings_path, notice: 'Profile has been updated'
    else
      flash.now[:danger] = current_user.first_error_message
      render :index
    end
  end

  # => PATCH /account/password
  def password
    if current_user.update(password_params)
      redirect_to account_settings_path, notice: 'Password has been updated'
      sign_in current_user, :bypass => true
    else
      flash.now[:danger] = current_user.first_error_message
      render :index
    end
  end

  protected
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:name, :email, :title)
    end
end
