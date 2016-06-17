class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    redirect_to root_path
  end
end
