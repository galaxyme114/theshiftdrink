class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user

      redirect_to(request.env["omniauth.origin"] + "?origin=auth", notice: 'You have been authenticated')
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to(:back, notice: @user.first_error_message)
    end
  end

  def failure
    redirect_to root_path
  end
end
