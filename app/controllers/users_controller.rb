class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authorize_user_profile, only: [:show]
  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)  # Connecter l'utilisateur après l'inscription
      redirect_to user_path(@user), notice: "Inscription réussie!"
    else
      render 'new'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profil mis à jour avec succès!"
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    sign_out(@user)  # Déconnecter l'utilisateur après la suppression du compte
    redirect_to root_path, notice: "Compte utilisateur supprimé avec succès!"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :description)
  end

  def authorize_user_profile
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à ce profil."
    end
  end
end
