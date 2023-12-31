class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path, notice: "ステータスを変更しました！"
  end

  private

   def user_params
     params.require(:user).permit(:name,:email,:is_deleted)
   end

end
