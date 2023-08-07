class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show

  end

  def edit

  end

  def update

  end

  def withdrawl

  end
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
  
end
