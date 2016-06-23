module ControllerHelpers
  def login_with(_user = double('user'), scope = :user)
    current_user = "current_#{scope}".to_sym
    login_appropriate_user(current_user)
  end

  def login_appropriate_user(current_user)
    if user.nil?
      no_user(current_user)
    else
      extant_user(current_user)
    end
  end

  def no_user
    allow(request.env['warden']).to
    receive(:authenticate!).and_throw(:warden, scope: scope)
    allow(controller).to receive(current_user).and_return(nil)
  end

  def extant_user
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(current_user).and_return(user)
  end
end
