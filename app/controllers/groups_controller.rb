class GroupsController < ApplicationController
  def index
    # 一覧表示のアクション
  end

  def new
    # 
    @group = Group.new
    # @groupに空のインスタンスを代入
    @group.users << current_user
    # 配列にcurrent_user要素を追加
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
      # もし保存がうまくいったら、rootパスにリンクする(メッセージ通知を表示しながら)
    else
      render :new
      # アクションなしでnewに飛ぶ
    end
  end

  def edit
    # 編集機能のアクション
    @group = Group.find(params[:id])
  end

  def update
    # 更新機能のアクション
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
      # もしgroup_paramsが更新できたら、rootパスにリンクする(メッセージ通知を表示しながら)
    else
      render :edit
      # アクションなしでeditに飛ぶ
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
    # # params.permit(:キー名, :キー名) = ストロングパラメーター。受け取りたいキーを指定する
    # 配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに「[]」
  end
end
