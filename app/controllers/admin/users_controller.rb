class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    @users = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "Compte utilisateur supprimé avec succès!"
  end

  private 


  def authenticate_admin
    if current_user.is_admin == false
      redirect_to root_path, notice:"Veuillez vous connecter en tant qu'administrateur "
    end
  end
end
