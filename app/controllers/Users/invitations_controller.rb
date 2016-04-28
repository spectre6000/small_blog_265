class Users::InvitationsController < Devise::InvitationsController
  before_action :non_admin_to_root, only: [:new, :create]
  before_action :update_sanitized_params, only: :update

  # GET /resource/invitation/new
  def new
    self.resource = resource_class.new
    render :new
  end

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        update_js_response
      end
      format.html do
        super
      end 
    end
  end

  protected

  def non_admin_to_root
    redirect_to(root_url) unless current_user.admin?
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:username, :password, :password_confirmation, :invitation_token)
    end
  end

  def invitation_token
    Devise.token_generator.digest(
      resource_class, 
      :invitation_token, 
      update_resource_params[:invitation_token]
    )
  end

  def update_js_response
    invitation_token
    self.resource = assign_resource
    resource.skip_password = true
    resource.update_attributes 
    resource.update_resource_params.except(:invitation_token)
  end

  def assign_resource
    resource_class.where(invitation_token: invitation_token).first
  end
end
