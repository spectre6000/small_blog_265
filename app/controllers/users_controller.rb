# Controller for Users (authors and commentors)
class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users = User.confirmed_users.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to User.find(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      flash[:danger] = 'Profile was not updated'
      render 'edit'
    end
  end

  def destroy
    delete_non_self_user
    redirect_to users_url
  end

  def toggle_admin
    @new_admin = User.find(params[:id])
    @new_admin.admin = true
    @new_admin.save
    # Probably convert to ajax after initial functionality is established
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:bio, :location, :profile_image, :banner_image)
  end

  # Confirms the correct user.
  def correct_user?
    current_user == @user ? true : false
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Deletes user if not self
  def delete_non_self_user
    if User.find(params[:id]).id != current_user.id
      User.find(params[:id]).destroy
      flash[:success] = 'User deleted.'
    else
      flash[:danger] = "You can't delete yourself."
    end
  end
end
