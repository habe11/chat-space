class UsersController < ApplicationController
  def edit
  end

  def index
    return nil if params[:keyword] == ""
    # もし、keywordの中身が"""ならnilを返す
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    # 「入力された値を含む」かつ「ログインしているユーザーのidは除外」の条件で取得
    # binding.pry
    respond_to do |format|
      format.html
      format.json 
    end
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
