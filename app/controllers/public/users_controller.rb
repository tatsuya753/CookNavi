class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_guest_user, only: [:edit]

  def index
    redirect_to new_user_registration_path
  end

  def show
    @user = User.find(params[:id])
    @user_posts = PostRecipe.where(user_id: @user, post_status: false).order(created_at: "DESC").page(params[:page])
    @kept_posts = PostRecipe.includes(:user).joins(:keeps).where(post_status: false,'keeps.user_id': @user.id).order('keeps.created_at': "DESC").page(params[:page])
    @draft_posts = PostRecipe.where(user_id: @user, post_status: true).order(created_at: "DESC").page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
        user = current_user
    if  user.update(user_params)
        redirect_to user_path
    else
        flash[:alert] = "プロフィールの更新ができませんでした。入力内容をご確認のうえ再度お試しください"
        redirect_to request.referer
    end
  end

  def destroy_image
    user = current_user
    user.profile_image.destroy  # 画像を削除する
    redirect_to edit_user_path(user), notice: "画像が削除されました。"
  end

  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image, :is_deleted )
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
