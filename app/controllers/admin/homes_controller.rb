class Admin::HomesController < ApplicationController

  def top
    @users = User.order(created_at: :desc)
    @users = Kaminari.paginate_array(@users).page(params[:page])
  end

end
