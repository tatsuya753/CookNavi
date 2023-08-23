class Public::PostRecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @recipe_comment = RecipeComment.all
    @categories = Category.all

    if  params[:category_id]
        @category = Category.find(params[:category_id])
        @post_recipes = @category.post_recipes.where(post_status: false).page(params[:page])

    elsif params[:word]
          @post_recipes = PostRecipe.where(post_status: false).looks(params[:word]).page(params[:page])
    else
          @post_recipes = PostRecipe.all.where(post_status: false).includes([:user]).page(params[:page])
    end
  end

  def show
    @post_recipe = PostRecipe.find(params[:id])
    @recipe_comment = RecipeComment.new
    @user = @post_recipe.user
  end

  def new
    @post_recipe = PostRecipe.new
    @post_recipe.ingredients.build
    @post_recipe.procedures.build
  end

  def create
    @post_recipe = PostRecipe.new(post_recipe_params)
    @post_recipe.user_id = current_user.id
    # 投稿ボタンを押下した場合
    if params[:post]
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe), notice: "レシピを投稿しました！"
      else
        flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end
    # 下書きボタンを押下した場合
    else
      if @post_recipe.update(post_status: true)
        redirect_to user_path(current_user), notice: "レシピを下書き保存しました！"
      else
        flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end
    end
  end

  def edit
    @post_recipe = PostRecipe.find(params[:id])
    @post_recipe.ingredients.build
    @post_recipe.procedures.build
  end

  def update
    @post_recipe = PostRecipe.find(params[:id])
    # 下書きレシピの更新（公開）の場合
    if params[:publicize_draft]
      # レシピ公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @post_recipe.attributes = post_recipe_params.merge(post_status: false)
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe.id), notice: "下書きのレシピを公開しました！"
      else
        @post_recipe.post_status = true
        flash.now[:alert] = "レシピを公開できませんでした。入力内容をご確認のうえ再度お試しください"
        render :edit
      end

    # 公開済みレシピの更新の場合
    elsif params[:update_post]
      @post_recipe.attributes = post_recipe_params
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe.id), notice: "レシピを更新しました！"
      else
        flash.now[:alert] = "レシピを公開できませんでした。入力内容をご確認のうえ再度お試しください"
        render :edit
      end

    # 下書きレシピの更新（非公開）の場合
    else
      if @post_recipe.update(post_recipe_params)
        redirect_to post_recipe_path(@post_recipe.id), notice: "下書きレシピを更新しました！"
      else
        flash.now[:alert] = "更新できませんでした。入力内容をご確認のうえ再度お試しください"
        render :edit
      end
    end
  end

  def destroy
    post_recipe = PostRecipe.find(params[:id])
    post_recipe.destroy
    redirect_to user_path(current_user), notice: "レシピを削除しました！"
  end

private

  def post_recipe_params
    params.require(:post_recipe).permit(
      :user_id,
      :category_id,
      :title,
      :introduction,
      :serving,
      :post_status,
      :image,
      procedures_attributes: [:body, :_destroy, :id],
      ingredients_attributes: [:name, :amount, :_destroy, :id]
    )
  end

end
