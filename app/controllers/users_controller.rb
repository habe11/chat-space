class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      # 現在のユーザーが更新された場合
      redirect_to root_path
      # rootパスにリダイレクトする
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
